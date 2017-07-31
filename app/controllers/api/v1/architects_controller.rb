module Api
  module V1
    class ArchitectsController < BaseApiController

      # GET /architects/:architect_id
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