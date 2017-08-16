module Api
  module V1
    class ArchitectsController < BaseApiController
      swagger_controller :architects, 'Manage requests for architect'

      before_action :verify_jwt_token, only: %i[like unlike]

      #---------------------------------------------------------
      # GET /architects
      swagger_api :index do
        summary 'Get architect list'
        param :query, :page, :integer, 'Page number'
      end

      def index
        @architects = Architect.page(params[:page]).all
        @total      = Architect.count
      end

      #---------------------------------------------------------
      # GET /architects/:architect_id
      swagger_api :show do
        summary 'Get information about architect'
        param :path, :architect_id, :string, 'Architect UUID'
        response :not_found
      end

      def show
        @architect = Architect.find(params[:architect_id])
      end

      #---------------------------------------------------------
      # GET /architects/:architect_id/houses?page=xxx
      swagger_api :houses do
        summary 'Get houses from an architect'
        param :path, :architect_id, :string, 'Architect UUID'
        param :query, :page, :integer, 'Page number. Default: 1'
        response :ok
        response :bad_request
      end

      def houses
        @houses = House.where(architect_id: params[:architect_id]).page(params[:page]).all
        @total  = House.where(architect_id: params[:architect_id]).count

        render status: common_http_status
      end

      #---------------------------------------------------------
      # GET /architects/:architect_id/photos?page=1
      # Get all photos belong to an architect
      swagger_api :photos do
        summary 'Get photos from an architect'
        param :path, :architect_id, :string, 'Architect UUID'
        param :query, :page, :integer, 'Page number. Default: 1'
        response :ok
        response :bad_request
      end

      def photos
        @photos = Photo.joins(:house).where('houses.architect_id = ?', params[:architect_id]).page(params[:page]).all
        @total  = Photo.joins(:house).where('houses.architect_id = ?', params[:architect_id]).count
        render status: common_http_status
      end


      #---------------------------------------------------------
      # POST /architects/:architect_id/like
      swagger_api :like do |api|
        summary 'Add architect to favorite list'
        notes 'Login required'
        param :path, :architect_id, :string, 'Architect UUID'
        BaseApiController::add_swagger_auth_params(api)
        BaseApiController::add_swagger_common_params(api)
      end

      def like
        @architect = Architect.find(params[:architect_id])
        FavoriteArchitect.where(user_id: current_user.id, architect_id: @architect.id).first_or_create
        render status: common_http_status
      end


      #---------------------------------------------------------
      # DELETE /architects/:architect_id/like
      swagger_api :unlike do |api|
        summary 'Remove architect from favorite list'
        notes 'Login required'
        param :path, :architect_id, :string, 'Architect UUID'
        BaseApiController::add_swagger_auth_params(api)
        BaseApiController::add_swagger_common_params(api)
      end

      def unlike
        @architect = Architect.find(params[:architect_id])
        FavoriteArchitect.destroy_all(user_id: current_user.id, architect_id: @architect.id)
      end


      #---------------------------------------------------------

      private

      #---------------------------------------------------------

    end
  end
end