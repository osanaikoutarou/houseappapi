module Api
  module V1
    #
    # Controller to handle house requests
    #
    class HousesController < BaseApiController
      swagger_controller :houses, 'Manage requests for house'

      before_action :load_house, only: %i[show photos]
      before_action :verify_jwt_token, only: %i[like unlike]

      #---------------------------------------------------------
      # GET /houses/:house_id
      swagger_api :show do
        summary 'Get detail information about a house'
        param :path, :house_id, :string, 'House uuid'
        response :not_found
      end

      def show
        @house = House.find(params[:house_id])
      rescue
        return head :not_found
      end

      #---------------------------------------------------------
      # GET /houses/:house_id/photos
      swagger_api :photos do
        summary 'List all photo for a house'
        param :path, :house_id, :string, :optional, 'House uuid'
        param :query, :page, :integer, :optional, 'Page number'
      end

      def photos
        @photos = Photo.where(house: @house).page(params[:page]).all
        @total  = Photo.where(house: @house).count

        render status: common_http_status
      end

      #---------------------------------------------------------
      # GET /houses/:house_id/featured_photos
      swagger_api :featured_photos do
        summary 'List all photo for a house'
        param :path, :house_id, :string, :required, 'House uuid'
      end

      def featured_photos
        @featured_photos = Photo.where(house: @house, featured_photo: true).limit(@row).offet(@offset).all
        @total           = Photo.where(house: @house, featured_photo: true).count

        render status: common_http_status
      end

      #---------------------------------------------------------
      # POST /houses/:id/like
      swagger_api :like do |api|
        summary 'Add house to favorite list'
        notes 'Login required'
        param :path, :architect_id, :string, :required, 'Architect UUID'
        BaseApiController::add_swagger_auth_params(api)
        BaseApiController::add_swagger_common_params(api)
      end

      def like
        house         = House.find(params[:house_id])
        favorite      = FavoriteHouse.first_or_initialize(user_id: current_user.id, house_id: house.id)
        favorite.like = true
        favorite.save!

        render status: common_http_status
      end


      #---------------------------------------------------------
      # POST /houses/:house_id/unlike
      swagger_api :unlike do |api|
        summary 'Remove house from favorite list'
        notes 'Login required'
        param :path, :house_id, :string, :required, 'Architect UUID'
        BaseApiController::add_swagger_auth_params(api)
        BaseApiController::add_swagger_common_params(api)
      end

      def unlike
        house         = House.find(params[:house_id])
        favorite      = FavoriteHouse.first_or_initialize(user_id: current_user.id, house_id: house.id)
        favorite.like = false
        favorite.save!

        render status: common_http_status
      end

      #---------------------------------------------------------

      private

      #---------------------------------------------------------

      def load_house
        @house = House.where(params[:id]).first
        return head :not_found unless @house.present?
      end

    end
  end
end