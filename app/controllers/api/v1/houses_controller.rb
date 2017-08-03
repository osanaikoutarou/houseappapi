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
      end

      #---------------------------------------------------------
      # GET /houses/:house_id/featured_photos
      def featured_photos
        @photos = Photo.where(house: @house, featured_photo: true).limit(20).all
      end

      private

      def load_house
        @house = House.where(params[:id]).first
        return head :not_found unless @house.present?
      end

    end
  end
end