class ApidocsController < ActionController::Base
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Houseapp API'
      key :description, ''
      contact do
        key :name, 'House app'
      end
      license do
        key :name, 'MIT'
      end
    end

    key :host, Rails.env.production? ? 'https://houseapp.herokuapp.com' : 'http://localhost:3000'
    key :basePath, '/'
    key :consumes, ['application/json']

    security_definition :login_required_auth do
      key :type, :apiKey
      key :name, :api_key
      key :in, :header
    end

  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
      Api::V1::AuthController,
      Api::V1::ArchitectsController,
      Api::V1::ProfileController,
      User,
      UserProfile,
      self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end