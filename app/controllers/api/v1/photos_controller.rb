module Api
  module V1
    #
    # Controller to handle photo requests
    #
    class PhotosController < BaseApiController
      include Swagger::Blocks

      before_action :verify_jwt_token, except: [:index]

      #---------------------------------------------------------
      # GET /api/photos
      swagger_path '/api/v1/photos' do
        operation :get do

          key :summary, 'Search for photos'
          key :description, ''
          key :tags, ['photo']

          parameter paramType: :query,
                    type: :string,
                    name: :keyword,
                    description: 'Keyword to search',
                    required: false

        end
      end
      def index
        @finder = Finder::PhotoFinder.new(Form::PhotoForm.new(params))
        @finder.find_photos
      end
            
      #---------------------------------------------------------
      # GET /photos/:photo_id
      swagger_api :show do
        summary 'Get detail information about a photo'
        param :path, :photo_id, :string, 'Photo UUID'
        response :not_found
      end

      def show
        @photo = Photo.find(params[:photo_id])
      rescue
        return head :not_found
      end
      
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

        @favorite      = FavoritePhoto.where(photo_id: photo_id, user_id: @current_user.id).first_or_initialize
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

        @favorite      = FavoritePhoto.where(photo_id: photo_id, user_id: @current_user.id).first_or_initialize
        @favorite.like = false
        @favorite.save!
      end

    end
  end
end
