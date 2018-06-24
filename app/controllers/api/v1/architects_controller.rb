module Api
  module V1
    class ArchitectsController < BaseApiController

      include Swagger::Blocks

      before_action :verify_jwt_token, only: %i[like unlike]

      #---------------------------------------------------------
      # GET /architects
      swagger_path '/api/v1/architects' do
        operation :get do

          key :summary, 'Search for architects'
          key :description, ''
          key :tags, ['architect']

          parameter paramType: :query,
                    type: :string,
                    name: :keyword,
                    description: 'Keyword to search',
                    required: false

        end
      end

      def index
        @finder = Finder::ArchitectFinder.new(Form::ArchitectForm.new(params))
        @finder.find_architects
      end

      def tags

        Architect.tags

      end

      #---------------------------------------------------------
      # GET /architects/:architect_id
      swagger_api :show do
        summary 'Get information about architect'
        param :path, :architect_id, :string, 'Architect UUID'
        response :not_found
      end

      def show
        @architect = Architect.find(params[:architect_id])
      end

      #---------------------------------------------------------
      # GET /architects/:architect_id/houses?page=xxx
      swagger_path '/api/v1/architects/{architect_id}/houses' do
        operation :get do
          key :summary, 'Get houses from an architect'
          key :description, ''
          key :tags, ['architect']
          parameter paramType: :path,
                    type: :string,
                    name: :architect_id,
                    description: 'Architect UUID',
                    required: true
          response 200 do
            key :description, 'List of houses'
            schema do
              property :total
              property :houses, '$ref' => :House
            end
          end
        end
      end
      def houses
        @houses = House.where(architect_id: params[:architect_id]).page(params[:page]).all
        @total  = House.where(architect_id: params[:architect_id]).count

        render status: common_http_status
      end

      #---------------------------------------------------------
      # GET /architects/:architect_id/photos?page=1
      # Get all photos belong to an architect
      swagger_api :photos do
        summary 'Get photos from an architect'
        param :path, :architect_id, :string, 'Architect UUID'
        param :query, :page, :integer, 'Page number. Default: 1'
        response :ok
        response :bad_request
      end

      def photos
        @photos = Photo.joins(:house).where('houses.architect_id = ?', params[:architect_id]).page(params[:page]).all
        @total  = Photo.joins(:house).where('houses.architect_id = ?', params[:architect_id]).count
        render status: common_http_status
      end


      #---------------------------------------------------------
      # POST /architects/:architect_id/like
      swagger_api :like do |api|
        summary 'Add architect to favorite list'
        notes 'Login required'
        param :path, :architect_id, :string, 'Architect UUID'
        BaseApiController::add_swagger_auth_params(api)
        BaseApiController::add_swagger_common_params(api)
      end

      def like
        architect     = Architect.find(params[:architect_id])
        favorite      = ArchitectLike.where(user_id: current_user.id, architect_id: architect.id).first_or_initialize
        favorite.like = true
        favorite.save!

        render status: common_http_status
      end


      #---------------------------------------------------------
      # POST /architects/:architect_id/unlike
      swagger_api :unlike do |api|
        summary 'Remove architect from favorite list'
        notes 'Login required'
        param :path, :architect_id, :string, 'Architect UUID'
        BaseApiController::add_swagger_auth_params(api)
        BaseApiController::add_swagger_common_params(api)
      end

      def unlike
        architect     = Architect.find(params[:architect_id])
        favorite      = ArchitectLike.where(user_id: current_user.id, architect_id: architect.id).first_or_initialize
        favorite.like = false
        favorite.save!
      end


      #---------------------------------------------------------

      private

      #---------------------------------------------------------

    end
  end
end