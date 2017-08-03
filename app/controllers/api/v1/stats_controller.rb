module Api
  module V1
    # Data
    class StatsController < BaseApiController
      swagger_controller :stats, 'Statistic data'
      #---------------------------------------------------------
      # GET /counter
      swagger_api :likes do
        summary 'Get LIKE statistics data'
        response :ok
        response :bad_request
      end
      def likes
        @stats = {
          photo_liked_count: FavoritePhoto.where(like: true).count,
          house_liked_count: FavoriteHouse.where(like: true).count,
          architect_liked_count: FavoriteArchitect.where(like: true).count
        }
        render status: common_http_status
      end
    end
  end
end
