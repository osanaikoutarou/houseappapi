
module Api
  module Admin
    class AuthController < BaseAdminApiController

      include Swagger::Blocks


      swagger_path "/api/admin/login" do
        operation :post do
          key :summary, 'Admin login'
          key :description, 'Admin login'
          key :tags, ['admin']
        end
      end
      def login

      end

    end
  end
end