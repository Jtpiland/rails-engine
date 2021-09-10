Rails.application.routes.draw do

  get '/api/v1/merchants/find', to: 'api/v1/merchants/find#index'
  get '/api/v1/items/find_all', to: 'api/v1/items/find_all#index'

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :most_items, only: [:index]
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: 'merchants/items'
      end
      resources :items, only: [:index, :show, :create, :destroy, :update] do
        resources :merchant, only: [:index], controller: 'items/merchants'
      end
      namespace :revenue do
        resources :items, only: [:index]
        resources :merchants, only: [:index, :show]
      end
    end
  end
end
