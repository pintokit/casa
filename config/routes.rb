Rails.application.routes.draw do
  root "flats#index"

  resources :pull, only: :bedrooms do
    member do
      get 'bedrooms'
    end
  end

  resources :flats do
    resources :listings, only: :index
  end
  resources :floorplans

  scope module: 'api' do
    namespace :v1 do
      resources :flats, only: :index do
        resources :listings, only: :index
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
