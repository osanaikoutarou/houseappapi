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
            photo_liked_count:     FavoritePhoto.where(like: true).count,
            house_liked_count:     FavoriteHouse.where(like: true).count,
            architect_liked_count: FavoriteArchitect.where(like: true).count
        }
        render status: common_http_status
      end


      #---------------------------------------------------------
      # GET /home
      swagger_api :home do
        summary 'Get data to display in home screen'
        param :query, :page, :integer, :optional, 'Page to show'
        response :ok
      end

      def home

        @stats = {
            photo_liked_count:     FavoritePhoto.where(like: true).count,
            house_liked_count:     FavoriteHouse.where(like: true).count,
            architect_liked_count: FavoriteArchitect.where(like: true).count
        }

        @architects = Architect.page(params[:page]).order('created_at DESC').all

        render status: common_http_status
      end

    end
  end
end
