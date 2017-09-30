class ApidocsController < ActionController::Base
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Houseapp API'
      key :description, 'A sample API that uses a petstore as an example to demonstrate features in the swagger-2.0 specification'
      contact do
        key :name, 'House app'
      end
      license do
        key :name, 'MIT'
      end
    end

    key :host, Rails.env.production? ? '' : 'http://localhost:3000'
    key :basePath, '/'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
      Api::V1::AuthController,
      User,
      self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end