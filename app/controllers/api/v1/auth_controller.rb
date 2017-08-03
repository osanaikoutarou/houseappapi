require 'rest-client'
require 'json'
require 'securerandom'

module Api
  module V1
    # Auth logic
    class AuthController < BaseApiController
      swagger_controller :auth, 'User authentication'

      before_action :verify_jwt_token, only: %i[profile update_profile change_password]

      #---------------------------------------------------------
      # POST /api/v1/auth/register
      swagger_api :register do
        summary 'Register new user.'
        param :form, :email, :string, :required
        param :form, :password, :string, :required
        response :ok
        response :bad_request
      end
      def register
        email    = params[:email]
        password = params[:password]

        user = User.new(email:    email,
                        password: password,
                        role:     User::ROLE_USER_REGISTERED)

        if user.save
          @user         = user
          @access_token = AuthToken.sign(user: @user.id)
        else
          @error         = ApiErrors::ATH010
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
        email    = params[:email]
        password = params[:password]

        user = verify_password(email, password)

        if user.nil?
          @error = ApiErrors::ATH001
        else
          @user         = user
          @access_token = AuthToken.sign(user: @user.id)
        end

        render '/api/v1/auth/login', status: common_http_status
      end

      #---------------------------------------------------------
      # GET /api/auth/profile
      swagger_api :profile do
        summary 'Get current user profile'
        response :ok
      end
      def profile
        @user         = current_user
        @user_profile = current_user.try(:user_profile)

        render status: common_http_status
      end

      #---------------------------------------------------------
      # PUT /api/auth/profile
      swagger_api :update_profile do
        summary 'Update profile for current login user'
        notes 'Authentication required'
      end
      def update_profile
        @user         = current_user
        @user_profile = current_user.user_profile || UserProfile.new(user: current_user)
        @user_profile.update(user_profile_params)

        render status: common_http_status
      end

      #---------------------------------------------------------
      # PUT /api/auth/password
      swagger_api :change_password do
        summary 'Update current password'
        param :form, :password, :string, :required
        param :form, :new_password, :string, :required
        response :ok
        response :bad_request
      end
      def change_password
        password     = params[:password]
        new_password = params[:new_password]

        if current_user.valid_password?(password)
          current_user.password              = new_password
          current_user.password_confirmation = new_password
          @error                             = ApiErrors::ATH091 unless current_user.save
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
