module Api
  module V1
    class HousesController < BaseApiController

      # GET /house/:house_id
      def show
        @house = House.find(params[:id])
      end

      # GET /houses/:house_id/photos
      # List all photo for a hosue
      def photos
      end

    end
  end
end