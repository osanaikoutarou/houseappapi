require 'rest-client'
require 'json'
require 'securerandom'

module Api
  module V1
    # Auth logic
    class AuthController < BaseApiController
      before_action :verify_jwt_token, only: %i[profile update_profile change_password]

      # Create an anonymous user without email
      # POST /api/v1/auth/anonymous
      api :POST, '/api/v1/auth/anonymous'
      description 'Create new anonymous user with random Email/Password'
      param :device_uuid, String
      param :device_name, String
      param :device_model, String
      param :device_idfv, String
      param :device_idfa, String
      param :device_gps_adid, String
      param :app_version, String

      def anonymous
        @anonymous = AnonymousUser.find
        device_uuid = params[:device_uuid] || SecureRandom.uuid
        @user          = AnomynousUser.where(id: uuid, role: User::ROLE_USER_ANONYMOUS).first_or_initialize
        @user.email    = "#{uuid}@temp.me"
        @user.password = SecureRandom.uuid
        @user.save!
        @token = AuthToken.sign(user: @user.id)
      end

      #======================================================
      # Login user
      # POST /api/auth/register
      api :POST, '/api/v1/auth/register'
      description 'Register new user by email and password'
      param :email, String
      param :password, String

      def register
        email       = params[:email]
        password    = params[:password]
        device_uuid = params[:device_uuid]

        user = User.where(id: device_uuid, role: User::ROLE_USER_ANONYMOUS).first
        if user.present?
          user.email    = email
          user.password = password
        else
          user = User.new(email: email, password: password)
        end
        user.role = User::ROLE_USER_REGISTERED

        if user.save
          @user  = user
          @token = AuthToken.sign(user: @user.id)
        else
          @error = APIErrors::ATH010
        end

        render status: common_http_status
      end

      #======================================================
      # Login user
      api :POST, '/api/auth/login/email'
      description 'Authenticate user by email and password'
      param :email, String
      param :password, String

      def email
        email    = params[:email]
        password = params[:password]

        user = verify_password(email, password)

        if user.nil?
          @error = APIErrors::ATH001
        else
          @user  = user
          @token = AuthToken.sign(user: @user.id)
        end

        render '/api/v1/auth/login', status: common_http_status
      end

      #======================================================
      # POST/DELETE/PUT /api/auth/logout
      api :POST, '/api/auth/logout'

      def logout
        # TODO: Update logout status in DB or expire current access_token
      end

      #======================================================
      # GET /api/auth/profile
      api :GET, '/api/auth/profile'
      description 'Get current user profile'

      def profile
        @user         = current_user
        @user_profile = current_user.try(:user_profile)
        @expert       = current_user.try(:expert)

        render status: common_http_status
      end

      #======================================================
      # Change password
      # PUT /api/auth/password
      api :PUT, '/api/auth/password'
      param :password, String
      param :new_password, String

      def change_password
        current_password = params[:password]
        new_password     = params[:new_password]

        if current_user.valid_password?(current_password)
          current_user.password = new_password
          @error                = APIErrors::ATH091 unless current_user.save
        else
          @error = APIErrors::ATH090
        end

        render status: common_http_status
      end

      private

      def verify_password(email, password)
        user = User.find_by_email(email)
        return user if user && user.valid_password?(password)
        return nil
      rescue => ex
        logger.error ex.inspect
        return nil
      end
    end
  end
end
