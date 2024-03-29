Rails.application.routes.draw do
  root 'delineation#index'
  
  resources :delineation, only: [:index, :create]
end
