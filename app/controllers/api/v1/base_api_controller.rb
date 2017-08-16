require 'auth_token'

class Api::V1::BaseApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json
  rescue_from ::Exception, with: :error_occurred
  attr_reader :current_user

  protected

  ##
  # This method can be used as a before filter to protect
  # any actions by ensuring the request is transmitting a
  # valid JWT.
  def verify_jwt_token
    # Verify header
    head(:unauthorized) && return if request.headers['Authorization'].blank?

    # Verify Bearer token
    token = request.headers['Authorization'].split(' ').last
    head(:unauthorized) && return if token.nil?
    payload = AuthToken.payload(token)
    head(:unauthorized) && return if payload.nil? || payload.empty?

    user_id = payload.first['user']
    if user_id
      @current_user = User.find(user_id)
      return
    end

    # Return unauthorized if user not found
    head :unauthorized
  rescue => ex
    logger.error ex.inspect
    head :unauthorized
  end

  def common_http_status
    @error.present? ? :bad_request : :ok
  end

  def self.add_swagger_common_params(api)
    api.response :ok
    api.response :bad_request
  end

  def self.add_swagger_auth_params(api)
    api.param :header, 'Authorization', :string, :required, 'Bearer AccessToken'
    api.response :unauthorized
  end

  def error_occurred(ex)
    logger.error ex.message
    ex.backtrace.each { |line| logger.error line }
    @error = ApiErrors::E00000
    @errors = [ex.message]
    render '/api/v1/error', status: common_http_status
  end
end
