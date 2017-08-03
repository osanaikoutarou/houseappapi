module Api
  module V1
    #
    # Controller to handle house requests
    #
    class HousesController < BaseApiController
      swagger_controller :houses, 'Manage requests for house'

      before_action :load_house, only: %i[show photos]

      #---------------------------------------------------------
      # GET /houses/:house_id
      swagger_api :show do
        summary 'Get detail information about a house'
        param :path, :house_id, :string, 'House uuid'
        response :not_found
      end
      def show
        @house = House.find(params[:house_id])
      rescue
        return head :not_found
      end

      #---------------------------------------------------------
      # GET /houses/:house_id/photos
      swagger_api :photos do
        summary 'List all photo for a house'
        param :path, :house_id, :string, 'House uuid'
      end
      def photos
        @photos = Photo.where(house: @house).limit(20).all
        @total = Photo.where(house: @house).count

        render status: common_http_status
      end

      #---------------------------------------------------------
      # GET /houses/:house_id/featured_photos
      swagger_api :featured_photos do
        summary 'List all photo for a house'
        param :path, :house_id, :string, 'House uuid'
      end
      def featured_photos
        @featured_photos = Photo.where(house: @house, featured_photo: true).limit(@row).offet(@offset).all
        @total = Photo.where(house: @house, featured_photo: true).count

        render status: common_http_status
      end

      private

      def load_house
        @house = House.where(params[:id]).first
        return head :not_found unless @house.present?
      end

      def paginate
        @row = 20
        @page   = (params[:page].to_i || 1).to_i
        @page   = 1 if @page < 1
        @offset = (@page - 1) * 20
      end

    end
  end
end