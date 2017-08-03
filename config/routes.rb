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
      end

      scope :auth do
        post  '/register' => 'auth#register'
        post  '/login'    => 'auth#login'

        match '/logout'         => 'auth#logout', via: %i[delete post put]
        get   '/profile'        => 'auth#profile'
        post  '/profile'        => 'auth#update_profile'
        put   '/password'       => 'auth#change_password'
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

    end
  end
end
