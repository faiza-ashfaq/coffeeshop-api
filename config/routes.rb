require 'sidekiq/web'

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: '/users', controllers: {
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions',
        passwords: 'api/v1/passwords',
        token_validations: 'api/v1/token_validations'
      }, skip: %i[omniauth_callbacks registrations]
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :carts, only: :show

      resources :items, only: %i[index show] do
        resources :cart_items, only: %i[create]
        patch 'update', to: 'cart_items#update'
        delete 'destroy', to: 'cart_items#destroy'
      end

      resources :orders, only: %i[index show]

      post 'checkout', to: 'orders#create'

      resource :user, only: %i[show update]

      namespace :admin do
        resources :combos do
          resources :offers, controller: 'combos/offers', only: %i[show create update destroy]
          get 'offer', to: 'combos/offers#show'
        end

        resources :items, only: %i[index show create update destroy]

        resources :offers, only: %i[index show create update destroy]
      end

      devise_scope :user do
        resources :users, only: [] do
          controller :registrations
        end
      end
    end
  end
end
