class Swagger::Docs::Config
  def self.transform_path(path, _api_version)
    # Make a distinction between the APIs and API documentation paths.
    "apidocs/#{path}"
  end
end

Swagger::Docs::Config.register_apis(
  '1.0' => {
    api_extension_type: :json,
    controller_base_path: '',
    api_file_path: 'public/apidocs',
    base_path: Rails.env.production? ? 'houseapp.herokuapp.com' : 'localhost:3000',
    clean_directory: true,
    attributes: {
      info: {
        'title' => 'Swagger Houseapp API',
        'description' => 'Swagger Houseapp API.',
        'license' => 'Apache 2.0',
        'licenseUrl' => 'http://www.apache.org/licenses/LICENSE-2.0.html'
      }
    },
    authorizations: {
        api_key: {
            type: 'apiKey',
            in: 'header',
            name: 'X-API-Key'
        },
        access_token: {
            type: 'apiKey',
            in: 'header',
            name: 'X-API-Key'
        }
    }
  }
)

SwaggerUiEngine.configure do |config|
  config.swagger_url = {
    admin: '/api/admin-specs',
    v1: '/api/specs'
  }
  config.request_headers = true
end
