Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'visitors#index'
  devise_for :users

  mount SwaggerUiEngine::Engine, at: '/api_docs'

  namespace :api do
    namespace :v1 do

      scope :anonymous do
        post '/' => 'anonymous#create'
        match '/preferences' => 'anonymous#preferences', via: %i[post put]
      end

      scope :architects do
        get '/' => 'architects#index'
        get '/:architect_id' => 'architects#show'
        get '/:architect_id/houses' => 'architects#houses'
        get '/:architect_id/photos' => 'architects#photos'
      end

      scope :auth do
        post '/register' => 'auth#register'
        post '/login' => 'auth#login'

        match '/logout' => 'auth#logout', via: %i[delete post put]
        get '/profile' => 'auth#profile'
        match '/profile' => 'auth#update_profile', via: %i[post put]
        match '/password' => 'auth#change_password', via: %i[post put]
        #match '/reset_password' => 'auth#reset_password', via: %i[post put] TODO: setup mail server
      end

      scope :houses do
        get '/:house_id' => 'houses#show'
        get '/:house_id/photos' => 'houses#photos'
        get '/:house_id/featured_photos' => 'houses#featured_photos'
      end

      scope :photos do
        post '/:photo_id/like' => 'photos#like'
        post '/:photo_id/pass' => 'photos#pass'
      end

      scope :stats do
        get '/likes' => 'stats#likes'
      end

    end
  end
end
