Rails.application.routes.draw do
  root "flats#index"

  get 'pull_studios', to: 'pull#studios'

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
