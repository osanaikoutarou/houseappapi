Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'visitors#index'
  devise_for :users

  mount SwaggerUiEngine::Engine, at: '/api_docs'

  resources :apidocs, path: '/api/specs', only: [:index]

  namespace :api do
    namespace :v1 do

      scope :architects do
        get '/' => 'architects#index'
        get '/:architect_id' => 'architects#show'
        get '/:architect_id/houses' => 'architects#houses'
        get '/:architect_id/photos' => 'architects#photos'
        post '/:architect_id/like' => 'architects#like'
        post '/:architect_id/unlike' => 'architects#unlike'
      end

      scope :auth do
        post '/guest' => 'auth#create_guest_user'
        post '/register' => 'auth#register'
        post '/login' => 'auth#login'
        post '/token/facebook' => 'auth#auth_facebook'

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
        post '/:house_id/like' => 'houses#like'
        post '/:house_id/unlike' => 'houses#unlike'
      end

      scope :photos do
        get '/likes' => 'photos#likes'
        post '/:photo_id/like' => 'photos#like'
        post '/:photo_id/pass' => 'photos#pass'
      end

      scope :profile do

        get '/favorite_architects' => 'profile#favorite_architects'
        get '/favorite_houses' => 'profile#favorite_houses'
        get '/favorite_photos' => 'profile#favorite_photos'

      end

      scope :search do

        get '/matched_architects' => 'search#matched_architects'
        get '/matching_photos' => 'search#matching_photos'

      end

      scope :stats do
        get '/likes' => 'stats#likes'
        get '/home' => 'stats#home'
      end

    end
  end
end
