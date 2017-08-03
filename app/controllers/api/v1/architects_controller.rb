module Api
  module V1
    class ArchitectsController < BaseApiController
      swagger_controller :architects, 'Manage requests for architect'

      before_action :paginate, only: %i[index houses photos]

      #---------------------------------------------------------
      # GET /architects
      swagger_api :index do
        summary 'Get architect list'
        param :query, :page, :integer, 'Page number'
      end

      def index
        @architects = Architect.limit(@row).offset(@offset).all
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
        @houses = House.where(architect_id: params[:architect_id]).limit(@row).offset(@offset).all

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
        @photos = Photo.joins(:house).where('houses.architect_id = ?', params[:architect_id]).limit(@row).offset(@offset).all
        render status: common_http_status
      end

      private

      def paginate
        @row = 20
        @page   = (params[:page].to_i || 1).to_i
        @page   = 1 if @page < 1
        @offset = (@page - 1) * 20
      end
    end
  end
end