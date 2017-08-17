module Api
  module V1
    # Auth logic
    class ProfileController < BaseApiController

      swagger_controller :profile, 'Current user profile'

      before_action :verify_jwt_token

      #---------------------------------------------------------
      swagger_api :favorite_architects do
        summary 'List favorite architects'
      end

      def favorite_architects
        @favorites = FavoriteArchitect.where(user_id: current_user.id)
                         .includes(:architect)
                         .page(params[:page])
                         .all
      end


      #---------------------------------------------------------
      swagger_api :favorite_houses do
        summary 'List favorite houses'
      end

      def favorite_houses
        @favorites = FavoriteHouse.where(user_id: current_user.id)
                         .includes(:architect)
                         .page(params[:page])
                         .all
      end

      #---------------------------------------------------------
      swagger_api :favorite_photos do
        summary 'List favorite photos'
      end

      def favorite_photos
        @favorites = FavoritePhoto.where(user_id: current_user.id)
                         .includes(:architect)
                         .page(params[:page])
                         .all
      end

    end
  end
end
