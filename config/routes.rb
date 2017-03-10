Rails.application.routes.draw do
  root "flats#index"

  resources :flats do
    resources :listings, only: :index
  end
  resources :floorplans

  scope module: 'api' do
    namespace :v1 do
      get 'all/:model_name', to: 'all#export'
      get 'flats/:hirise', to: 'flats#api'
      get 'listings/:flat_id', to: 'listings#api'
    end
  end

end
