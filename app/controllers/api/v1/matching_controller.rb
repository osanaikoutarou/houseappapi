module Api
  module V1

    # API for matching data with current
    class MatchingController < BaseApiController

      #---------------------------------------------------------
      # GET /
      swagger_api :index do
        summary 'Get data to display in home screen'
        param :query, :page, :integer, :optional, 'Page to show'
        response :ok
      end

      def index

        @stats = {
            photo_likes_count:     FavoritePhoto.where(like: true).count,
            house_likes_count:     FavoriteHouse.where(like: true).count,
            architect_likes_count: FavoriteArchitect.where(like: true).count
        }

        @architects = Architect.page(params[:page]).order('created_at DESC').all

        render status: common_http_status
      end
    end

  end
end