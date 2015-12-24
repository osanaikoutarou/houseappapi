class API < Grape::API
  prefix 'api'
  version 'v1', using: :path
  format :json

  # http://kzy52.com/entry/2014/11/07/084023
  # 例外ハンドル 404
  rescue_from ActiveRecord::RecordNotFound do |e|
    rack_response({ message: e.message, status: 404 }.to_json, 404)
  end

  # 例外ハンドル 400
  rescue_from Grape::Exceptions::ValidationErrors do |e|
    rack_response e.to_json, 400
  end

  # 例外ハンドル 500
  rescue_from :all do |e|
    if Rails.env.development?
      raise e
    else
      error_response(message: "Internal server error", status: 500)
    end
  end

  # # #

  helpers do
    def dummy_name
      "dummy"
    end

    def err401
      error!('401 Unauthorized', 401)
    end
  end

  resource :room do

    get :status do
      "room is good"
    end

    get :secret do
      err401
    end
  end

end
