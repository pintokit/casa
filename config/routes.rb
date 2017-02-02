require 'api_constraints'

Rails.application.routes.draw do
  root "flats#index"

  get 'pull_studios', to: 'pull#studios'

  resources :flats do
    resources :listings
  end

  resources :floorplans

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :flats, :only =>[:index]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
