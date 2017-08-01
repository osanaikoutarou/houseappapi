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
      end
      def register
        email       = params[:email]
        password    = params[:password]

        user = User.new(email: email,
                        password: password,
                        role: User::ROLE_USER_REGISTERED)

        if user.save
          @user  = user
          @access_token = AuthToken.sign(user: @user.id)
        else
          @error = APIErrors::ATH010
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
      end
      def login
        email    = params[:email]
        password = params[:password]

        user = verify_password(email, password)

        if user.nil?
          @error = APIErrors::ATH001
        else
          @user  = user
          @access_token = AuthToken.sign(user: @user.id)
        end

        render '/api/v1/auth/login', status: common_http_status
      end

      #---------------------------------------------------------
      # GET /api/auth/profile
      swagger_api :profile do
        summary 'Get current user profile'
      end
      def profile
        @user         = current_user
        @user_profile = current_user.try(:user_profile)
        @expert       = current_user.try(:expert)

        render status: common_http_status
      end

      #---------------------------------------------------------
      # PUT /api/auth/password
      swagger_api :profile do
        summary 'Update current password'
        param :form, :current_password, :string, :required
        param :form, :new_password, :string, :required
      end
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
    end
  end
end
