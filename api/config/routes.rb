Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'visitors#index'
  devise_for :users

  namespace :api do
    namespace :v1 do
      scope :auth do
        post  '/anonymous' => 'auth#anonymous'
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
