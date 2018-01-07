
module Api
  module Admin
    class AuthController < BaseAdminApiController

      include Swagger::Blocks

      swagger_path '/api/admin/login' do
        operation :post do
          key :summary, 'Admin login'
          key :description, 'Login to access APIs for Admins. Admin username and PW are required.'
          key :tags, ['admin']

          parameter paramType: :body,
                    type: :string,
                    name: :username,
                    description: 'Admin login username',
                    required: true

          parameter paramType: :body,
                    type: :string,
                    name: :password,
                    description: 'Admin login password',
                    required: true

          response 200
        end
      end
      def login

        email = params[:email]
        password = params[:password]

        admin = verify_admin(email, password)

        if admin
          access_token = AuthToken.sign(user: admin.id, scope: 'admin')

          render json: {access_token: access_token}, status: 200
        else

          render json: {access_token: ''}, status: 200
        end

      end

      def verify_admin(email, password)
        admin = Admin.find_by_email(email)
        return admin if admin && admin.valid_password?(password)
        return nil
      rescue => ex
        logger.error ex.inspect
        return nil
      end

    end
  end
end