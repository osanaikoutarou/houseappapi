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
          key :tags, ['auth']
          parameter paramType: :body,
                    type: :string,
                    name: :device_uuid,
                    description: 'Unique device UUID',
                    required: false
          response 200 do
            key :description, 'Create new guest user'
            schema do
              property :user, '$ref' => :User
              property :access_token, type: :string
              property :device_uuid, type: :string
            end
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
      swagger_path '/api/v1/auth/register' do
        operation :post do
          key :summary, 'Create new user with email and address. '
          key :description, 'If device UUID is included in request body, server will migrate exising device UUID with new created user'
          key :tags, ['auth']
          parameter paramType: :body,
                    type: :string,
                    name: :email,
                    description: 'Email to register',
                    required: true
          parameter paramType: :body,
                    type: :string,
                    name: :password,
                    description: 'Password to register',
                    required: true
          parameter paramType: :body,
                    type: :string,
                    name: :device_uuid,
                    description: 'Device UUID for guest user',
                    required: false
          response 200 do
            key :description, 'Create new guest user'
            schema do
              property :user, '$ref' => :User
              property :access_token, type: :string
              property :device_uuid, type: :string
            end
          end
        end
      end
      def register
        email = params[:email]
        password = params[:password]

        user = User.new
        user.email = email
        user.password = password
        user.role = User::ROLE_USER_REGISTERED
        user.device_uuid = SecureRandom.uuid

        # TODO: migrate data from existing guest user

        if user.save
          @user = user
          @device_uuid = user.device_uuid
          @access_token = AuthToken.sign(user: @user.id, device: @user.device_uuid, scope: 'user')
        else
          @error = ApiErrors::ATH010
          @error.message = user.errors
        end

        render status: common_http_status
      end

      #---------------------------------------------------------
      # POST /api/v1/auth/login
      swagger_path '/api/v1/auth/login' do
        operation :post do
          key :summary, 'Login with email and address. '
          key :description, ''
          key :tags, ['auth']
          parameter paramType: :body,
                    type: :string,
                    name: :email,
                    description: 'Email to register',
                    required: true
          parameter paramType: :body,
                    type: :string,
                    name: :password,
                    description: 'Password to register',
                    required: true
          response 200 do
            key :description, 'Create new guest user'
            schema do
              property :user, '$ref' => :User
              property :access_token, type: :string
              property :device_uuid, type: :string
            end
          end
        end
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
      swagger_path '/api/v1/auth/token/facebook' do
        operation :post do
          key :summary, 'Login with Facebook access token.'
          key :description, ''
          key :tags, ['auth']

          parameter paramType: :body,
                    type: :string,
                    name: :access_token,
                    description: 'Access token from Facebook SDK',
                    required: true

          response 200 do
            key :description, 'Successfully authenticate with FB access token'
            schema do
              property :user, '$ref' => :User
              property :access_token, type: :string
              property :device_uuid, type: :string
            end
          end
        end
      end
      def auth_facebook

        token = params[:access_token]
        device_uuid = params[:device_uuid]

        # Try to verify facebook's access token
        user = verify_facebook_token(token, device_uuid)

        unless user.nil?
          @user = user
          @access_token = AuthToken.sign(user: @user.id, device: @user.device_uuid, scope: 'user')
          @device_uuid = user.device_uuid
        end

        render '/api/v1/auth/register', :status => common_http_status
      end

      #---------------------------------------------------------
      # GET /api/auth/profile
      swagger_path '/api/v1/auth/profile' do
        operation :get do
          key :summary, 'Get profile for current login user.'
          key :description, ''
          key :tags, ['auth']

          security do
            key :login_required_auth, []
          end

          response 200 do
            schema do
              property :user, '$ref' => :User
              property :user_profile, '$ref' => :UserProfile
            end
          end
        end
      end
      def profile
        @user = current_user
        @user_profile = current_user.try(:user_profile)

        render status: common_http_status
      end

      #---------------------------------------------------------
      # PUT /api/auth/profile
      swagger_path '/api/v1/auth/profile' do
        operation :put do
          key :summary, 'Update profile for current login user'
          key :tags, ['auth']

          security do
            key :login_required_auth, []
          end

          response 200 do
            schema do
              property :user, '$ref' => :User
              property :user_profile, '$ref' => :UserProfile
            end
          end
        end

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

      private
      def verify_password(email, password)
        user = User.find_by_email(email)
        return user if user && user.valid_password?(password)
        return nil
      rescue => ex
        logger.error ex.inspect
        return nil
      end

      def verify_facebook_token(token, device_uuid)
        graph = Koala::Facebook::API.new(token)

        # https://developers.facebook.com/docs/graph-api/reference/user/
        profile = graph.get_object('me?fields=id,name,email,picture.width(800).height(800),cover')
        logger.debug "[API::Authenticate::Facebook] Login user: #{profile.inspect}"

        user = User.where(facebook_id: profile['id']).first
        if user.nil?
          user = User.new
          user.password = SecureRandom.base64
          user.email = profile['email']
          user.facebook_id = profile['id']
          user.facebook_access_token = token
          user.device_uuid = device_uuid || SecureRandom.uuid
          user.save!

          user_profile = user.user_profile || UserProfile.new(user: user)
          user_profile.first_name = profile['first_name']
          user_profile.last_name = profile['last_name']
          user_profile.save!
          user.user_profile = user_profile # Rebind user-profile if it was null

        elsif user.email != profile['email']
            #Existing users, return error and ask user if they want to link-account
            @error = ApiErrors::ATH030
            return nil
        else
          # TODO: Update info from Facebook?
        end

        return user

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
