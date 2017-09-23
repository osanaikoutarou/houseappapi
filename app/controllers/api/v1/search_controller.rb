module Api
  module V1

    # API for matching data with current
    class SearchController < BaseApiController
      swagger_controller :search, 'Search for architect, house, photo'

      #---------------------------------------------------------
      # GET /matching
      swagger_api :matched_architects do
        summary 'Get data to display in home screen'
        param :query, :page, :integer, :optional, 'Page to show'
        response :ok
      end
      def matched_architects

        page = params[:page].to_i || 0

        @user = current_user
        @likes = {
            photo_likes_count: FavoritePhoto.likes.by_user(@user).count,
            house_likes_count: FavoriteHouse.likes.by_user(@user).count,
            architect_likes_count: FavoriteArchitect.likes.by_user(@user).count
        }

        @architects = Architect.match_favorites_for_user(@user, page)

        render status: common_http_status
      end
    end

  end
end