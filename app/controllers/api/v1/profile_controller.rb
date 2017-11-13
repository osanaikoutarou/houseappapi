module Api
  module V1
    # Auth logic
    class ProfileController < BaseApiController

      include Swagger::Blocks

      before_action :verify_jwt_token

      #---------------------------------------------------------
      swagger_api :favorite_architects do
        summary 'List favorite architects'
      end
      swagger_path '/api/v1/profile/favorite_architects' do

        operation :get do
          key :summary, 'List of favorite architects for current user.'
          key :description, ''
          key :tags, ['profile']

          parameter paramType: :query,
                    type: :string,
                    name: :per_page,
                    description: 'Number of records. Default: 25',
                    required: false

          parameter paramType: :query,
                    type: :string,
                    name: :page,
                    description: 'Current page',
                    required: false

        end
      end
      def favorite_architects
        @page = params[:page] || 1
        @per_page = params[:per_page] || 25
        @total = FavoriteArchitect.where(user_id: current_user.id).count
        favorites = FavoriteArchitect.where(user_id: current_user.id)
                         .includes(:architect)
                         .page(params[:page])
                         .all

        @architects = favorites.map { |f| f.architect }

      end


      #---------------------------------------------------------
      swagger_path '/api/v1/profile/favorite_houses' do

        operation :get do
          key :summary, 'List of favorite architects for current user.'
          key :description, ''
          key :tags, ['profile']

          parameter paramType: :query,
                    type: :string,
                    name: :per_page,
                    description: 'Number of records. Default: 25',
                    required: false

          parameter paramType: :query,
                    type: :string,
                    name: :page,
                    description: 'Current page',
                    required: false

        end
      end

      def favorite_houses
        @page = params[:page] || 1
        @per_page = params[:per_page] || 25
        @total = FavoriteHouse.where(user_id: current_user.id).count
        favorites = FavoriteHouse.where(user_id: current_user.id)
                      .includes(:house)
                      .page(@page)
                      .per(@per_page)
                      .all

        @houses = favorites.map { |f| f.house }
      end

      #---------------------------------------------------------
      swagger_path '/api/v1/profile/favorite_photos' do

        operation :get do
          key :summary, 'List of favorite photos for current user.'
          key :description, ''
          key :tags, ['profile']

          parameter paramType: :query,
                    type: :string,
                    name: :per_page,
                    description: 'Number of records. Default: 25',
                    required: false

          parameter paramType: :query,
                    type: :string,
                    name: :page,
                    description: 'Current page',
                    required: false

        end
      end

      def favorite_photos
        @page = params[:page] || 1
        @per_page = params[:per_page] || 25
        @total = FavoritePhoto.where(user_id: current_user.id).count
        favorites = FavoritePhoto.where(user_id: current_user.id)
                      .includes(:photo)
                      .page(@page)
                      .per(@per_page)
                      .all

        @photos = favorites.map {|f| f.photo}
      end

    end
  end
end
