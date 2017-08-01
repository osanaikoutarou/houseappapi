module Api
  module V1
    #
    # Controller to handle photo requests
    #
    class PhotosController < BaseApiController
      swagger_controller :photos, 'Manage requests for photo'

      before_action :verify_jwt_token

      # POST /api/photos/:photo_id/like
      swagger_api :like do
        summary 'Marks photo as favorite for current user'
        notes 'User must be logged in'
        param :path, :photo_id, :string, :required
        response :unauthorized
        response :not_found
      end
      def like
        photo_id = params[:photo_id]
        head status: :not_found && return unless Photo.exists?(photo_id)

        @favorite = FavoritePhoto.find_or_initialize_by(photo_id: photo_id, user_id: @current_user.id)
        @favorite.like = true
        @favorite.save!
      end

      # POST /api/photos/:photo_id/pass
      swagger_api :pass do
        summary 'Marks photo as no interest for current user'
        notes 'User must be logged in'
        param :path, :photo_id, :string, :required
        response :unauthorized
        response :not_found
      end
      def pass
        photo_id = params[:photo_id]
        head status: :not_found && return unless Photo.exists?(photo_id)

        @favorite = FavoritePhoto.find_or_initialize_by(photo_id: photo_id, user_id: @current_user.id)
        @favorite.like = false
        @favorite.save!
      end
    end
  end
end
