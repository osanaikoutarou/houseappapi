module Admin

  class BaseAdminController < ApplicationController

    layout 'admin/application'

    before_action :authenticate_admin_user!

  end

end