Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :documents, only: :index

  mount API::Mount => '/api'

end
