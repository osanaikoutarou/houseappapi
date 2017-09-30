require 'rest-client'
require 'json'
require 'securerandom'

module Api
  module V1
    # Auth logic
    class AuthController < BaseApiController
      include Swagger::Blocks

      before_action :verify_jwt_token, only: %i[profile update_profile change_password]

      #---------------------------------------------------------
      swagger_path '/api/v1/auth/guest' do
        operation :post do
          key :summary, 'Create guest user'
          key :description, 'App side should call this in first installation and store uuid and access token locally'
          parameter do
            key :name, :device_uuid
            key :in, :body
            key :type, :string
            key :description, 'Unique device UUID'
            key :required, false
          end
          response 200 do
            key :description, 'Guest user login'
          end
        end
      end
      def create_guest_user
        @device_uuid = params[:device_uuid]
        if @device_uuid.blank?
          @device_uuid = SecureRandom.uuid
        end

        email = "#{@device_uuid}@temp.me"
        @user = User.where(email: email).first_or_initialize
        @user.email = email
        @user.password = @device_uuid
        @user.device_uuid = @device_uuid
        @user.role = User::ROLE_USER_ANONYMOUS

        @user.save!
        @access_token = AuthToken.sign(user: @user.id, device: @device_uuid, scope: 'guest')

        render 'api/v1/auth/register', status: common_http_status
      end
      #---------------------------------------------------------
      # POST /api/v1/auth/register
      swagger_api :register do
        summary 'Register new user.'
        param :form, :email, :string, :required
        param :form, :password, :string, :required
        param :form, :device_uuid, :string, :optional
        response :ok
        response :bad_request
      end
      def register
        email = params[:email]
        password = params[:password]

        user = User.first_or_initialize(device_uuid: params[:device_uuid])
        user.email = email
        user.password = password
        user.role = User::ROLE_USER_REGISTERED
        user.device_uuid = SecureRandom.uuid unless @user.device_uuid?

        if user.save
          @user = user
          @access_token = AuthToken.sign(user: @user.id, device: @user.device_uuid, scope: 'user')
        else
          @error = ApiErrors::ATH010
          @error.message = user.errors
        end

        render status: common_http_status
      end

      #---------------------------------------------------------
      # POST /api/v1/auth/login
      swagger_api :login do
        summary 'Login with email/password.'
        param :form, :email, :string, :required
        param :form, :password, :string, :required
        response :ok
        response :bad_request
      end
      def login
        email = params[:email]
        password = params[:password]

        user = verify_password(email, password)

        if user.nil?
          @error = ApiErrors::ATH001
        else
          @user = user
          @user.device_uuid = SecureRandom.uuid unless @user.device_uuid?
          @access_token = AuthToken.sign(user: @user.id, device: @user.device_uuid, scope: 'user')
        end

        render '/api/v1/auth/login', status: common_http_status
      end

      #---------------------------------------------------------
      # GET /api/auth/profile
      swagger_api :profile do
        summary 'Get current user profile'
        param :header, 'Authorization', :string, :required, 'Bearer AccessToken'
        response :ok
        response :bad_request
        response :unauthorized
      end
      def profile
        @user = current_user
        @user_profile = current_user.try(:user_profile)

        render status: common_http_status
      end

      #---------------------------------------------------------
      # PUT /api/auth/profile
      swagger_api :update_profile do
        summary 'Update profile for current login user'
        param :header, 'Authorization', :string, :required, 'Bearer AccessToken'
        notes 'Authentication required'
        response :ok
        response :bad_request
        response :unauthorized
      end
      def update_profile
        @user = current_user
        @user_profile = current_user.user_profile || UserProfile.new(user: current_user)
        @user_profile.update(user_profile_params)

        render status: common_http_status
      end

      #---------------------------------------------------------
      # PUT /api/auth/password
      swagger_api :change_password do
        summary 'Update current password'
        param :header, 'Authorization', :string, :required, 'Bearer AccessToken'
        param :form, :password, :string, :required
        param :form, :new_password, :string, :required
        response :ok
        response :bad_request
        response :unauthorized
      end
      def change_password
        password = params[:password]
        new_password = params[:new_password]

        if current_user.valid_password?(password)
          current_user.password = new_password
          current_user.password_confirmation = new_password
          @error = ApiErrors::ATH091 unless current_user.save
        else
          @error = ApiErrors::ATH090
        end

        render status: common_http_status
      end

      #---------------------------------------------------------
      # POST reset_password
      swagger_api :reset_password do
        summary 'Send email to reset current password'
        param :form, :email, :string, :required
        response :ok
        response :bad_request
      end
      def reset_password
        email = params[:email]
        head :bad_request && return if email.blank? # TODO: validate email format

        user = User.where(email: email).first
        user.send_reset_password_instructions

        render status: common_http_status
      end


      #---------------------------------------------------------

      private

      #---------------------------------------------------------

      def verify_password(email, password)
        user = User.find_by_email(email)
        return user if user && user.valid_password?(password)
        return nil
      rescue => ex
        logger.error ex.inspect
        return nil
      end

      def user_profile_params
        params.permit(:first_name,
                      :last_name,
                      :first_name_kana,
                      :last_name_kana,
                      :gender,
                      :zip_code,
                      :prefecture,
                      :city,
                      :address1,
                      :address2
        )

      end
    end
  end
end
