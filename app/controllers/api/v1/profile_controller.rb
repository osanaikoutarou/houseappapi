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

        form = Form::ArchitectForm.new(params)
        form.current_user = @current_user
        @finder = Finder::ArchitectFinder.new(form)

        @finder.find_favorite_architects

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

        form = Form::HouseForm.new(params)
        form.current_user = @current_user
        @finder = Finder::HouseFinder.new(form)

        @finder.find_favorite_houses
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

        form = Form::PhotoForm.new(params)
        form.current_user = @current_user
        @finder = Finder::PhotoFinder.new(form)
        @finder.find_favorite_photos
      end

    end
  end
end
