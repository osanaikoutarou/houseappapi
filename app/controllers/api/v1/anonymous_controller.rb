module Api
  module V1
    class AnonymousController < BaseApiController
      swagger_controller :anonymous, 'Manage requests from Anonymous users'

      before_action :verify_anonymous_token, only: %i[preferences]

      # POST /api/v1/auth/anonymous
      swagger_api :create do
        summary 'Register new anonymous user.'
        notes 'App side should call this in first installation and store uuid, anonymous_token locally'
        param :form, :device_uuid, :string, :optional, 'Device UUID'
        param :form, :device_name, :string, :optional, 'Android / iOS'
        param :form, :device_model, :string, :optional, 'iPhone 7'
        param :form, :device_idfv, :string, :optional
        param :form, :device_idfa, :string, :optional
        param :form, :device_gps_adid, :string, :optional
        param :form, :app_version, :string, :optional
        param :form, :preferences, :string, :optional
      end
      def create
        uuid                       = params[:device_uuid] || SecureRandom.uuid
        @anonymous                 = AnonymousUser.where(id: uuid).first_or_initialize

        @anonymous.device_name     = params[:device_name]
        @anonymous.device_model    = params[:device_model]
        @anonymous.device_idfv     = params[:device_idfv]
        @anonymous.device_idfa     = params[:device_idfa]
        @anonymous.device_gps_adid = params[:device_gps_adid]
        @anonymous.app_version     = params[:app_version]
        @anonymous.preferences     = params[:preferences]
        @anonymous.save!

        @access_token = AuthToken.sign(anonymous: uuid)
      end

      #---------------------------------------------------------
      # POST /api/v1/auth/anonymous
      swagger_api :show do
        summary 'Get current anonymous device information'
        notes 'Anonymous access_token is required'
        param :path, :id, :string, :required, 'Device anonymous ID'
        response :ok
      end
      def show

        @anonymous = AnonymousUser.find(params[:id])

      end

      # POST /api/v1/auth/anonymous
      swagger_api :preferences do
        summary 'Register new anonymous user.'
        notes 'App side should call this in first installation and store uuid, anonymous_access_token locally'
        param :form, :key, :string, :required
        param :form, :value, :string, :required
      end
      def preferences
        preferences               = @anonymous.preferences || {}
        preferences[params[:key]] = params[:value]
        @anonymous.preferences    = preferences
        @anonymous.save!
      end

      # POST /api/v1/anonymous/migrate
      def migrate
        # TODO: create new user
      end

      #---------------------------------------------------------

      private

      #---------------------------------------------------------

      def verify_anonymous_token
        # Verify Bearer token
        head(:unauthorized) && return if request.headers['Authorization'].blank?
        access_token = request.headers['Authorization'].split(' ').last
        head(:unauthorized) && return if access_token.nil?
        payload = AuthToken.payload(access_token)
        head(:unauthorized) && return if payload.nil? || payload.empty?

        uuid = payload.first['anonymous']
        if uuid
          @anonymous = AnonymousUser.find(uuid)
          return
        end

        # Return unauthorized if user not found
        head :unauthorized
      end
    end
  end
end
