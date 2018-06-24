module Api
  module V1

    # API for matching data with current
    class SearchController < BaseApiController
      swagger_controller :search, 'Search for architect, house, photo'


      #---------------------------------------------------------
      # GET /matching_photos
      swagger_api :matching_photos do
        summary 'Get random photos for matching. Default: 30 photos per request'
      end
      def matching_photos
        @photos = Photo.includes(:house, :architect).limit(30).order('RANDOM()')
        render status: common_http_status
      end

      #---------------------------------------------------------
      # GET /matched_architects
      swagger_api :matched_architects do
        summary 'Get data to display in home screen'
        param :query, :page, :integer, :optional, 'Page to show'
        response :ok
      end
      def matched_architects

        @user = current_user
        @likes = {
            photo_likes_count: PhotoLike.likes.by_user(@user).count,
            house_likes_count: HouseLike.likes.by_user(@user).count,
            architect_likes_count: ArchitectLike.likes.by_user(@user).count
        }

        form = Form::ArchitectForm.new(params)
        form.current_user = current_user
        @finder = Finder::ArchitectFinder.new(form)
        @finder.match_architects

        render status: common_http_status
      end
    end

  end
end