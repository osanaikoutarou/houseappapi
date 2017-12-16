
module Api
  module Admin
    class BaseAdminApiController < ApplicationController

      skip_before_action :verify_authenticity_token

    end
  end
end