module Api
  module V1
    class ArchitectsController < BaseApiController
      swagger_controller :architects, 'Manage requests for architect'

      # GET /architects
      swagger_api :index do
        summary 'Get architect list'
        param :query, :page, :integer, 'Page number'
      end

      def index
        page   = (params[:page].to_i || 1).to_i
        page   = 1 if page < 1
        offset = (page - 1) * 20

        @architects = Architect.limit(20).offset(offset).all
      end

      # GET /architects/:architect_id
      swagger_api :show do
        summary 'Get information about architect'
        param :path, :architect_id, :string, 'Architect UUID'
        response :not_found
      end

      def show
        @architect = Architect.find(params[:architect_id])
      end

      # GET /architects/:architect_id/houses?page=xxx
      def houses
        @houses = House.where(architect_id: params[:architect_id]).all
      end

      # GET /architects/:architect_id/photos?page=1
      # Get all photos belong to an architect
      def photos
        @photos = Photo
      end
    end
  end
end