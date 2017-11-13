module Api
  module V1
    #
    # Controller to handle photo requests
    #
    class PhotosController < BaseApiController
      include Swagger::Blocks

      before_action :verify_jwt_token

      #---------------------------------------------------------
      # POST /api/photos/:photo_id/like
      swagger_path '/api/v1/photos/:photo_id/like' do
        operation :post do
          key :summary, 'Marks photo as favorite for current user'
          key :description, ''
          key :tags, ['photo']

          parameter paramType: :path,
                    type: :string,
                    name: :photo_id,
                    description: 'Photo UUID',
                    required: true

          security do
            key :login_required_auth, []
          end

          response 200 do
          end
        end
      end

      def like
        photo_id = params[:photo_id]
        head status: :not_found && return unless Photo.exists?(photo_id)

        @favorite      = FavoritePhoto.where(photo_id: photo_id, user_id: @current_user.id).find_or_initialize
        @favorite.like = true
        @favorite.save!
      end

      #---------------------------------------------------------
      # POST /api/photos/:photo_id/pass
      swagger_path '/api/v1/photos/:photo_id/pass' do
        operation :post do
          key :summary, 'Marks photo as no interest for current user'
          key :description, ''
          key :tags, ['photo']

          parameter paramType: :path,
                    type: :string,
                    name: :photo_id,
                    description: 'Photo UUID',
                    required: true

          security do
            key :login_required_auth, []
          end

          response 200 do
          end
        end
      end

      def pass
        photo_id = params[:photo_id]
        head status: :not_found && return unless Photo.exists?(photo_id)

        @favorite      = FavoritePhoto.where(photo_id: photo_id, user_id: @current_user.id).find_or_initialize
        @favorite.like = false
        @favorite.save!
      end
    end
  end
end
