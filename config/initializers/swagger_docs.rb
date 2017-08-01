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
    base_path: ENV['BASE_URL'],
    clean_directory: true,
    attributes: {
      info: {
        'title' => 'Swagger Houseapp API',
        'description' => 'Swagger Houseapp API.',
        'license' => 'Apache 2.0',
        'licenseUrl' => 'http://www.apache.org/licenses/LICENSE-2.0.html'
      }
    }
  }
)

SwaggerUiEngine.configure do |config|
  config.swagger_url = {
    v1: '/apidocs/api-docs.json'
  }
end
