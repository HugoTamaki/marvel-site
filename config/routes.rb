Rails.application.routes.draw do
  root to: 'comics#index'

  resources :comics, only: :index do
    constraints format: :json do
      post 'favourite_comic', as: :favourite_comic, on: :collection
    end
  end
end
