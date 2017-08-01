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

      scope :auth do
        post  '/register' => 'auth#register'
        post  '/login'    => 'auth#login'

        match '/logout'         => 'auth#logout', via: %i[delete post put]
        get   '/profile'        => 'auth#profile'
        post  '/profile'        => 'auth#update_profile'
        put   '/password'       => 'auth#change_password'
      end
    end
  end
end
