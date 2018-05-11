Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :documents, only: :index
  resource :setting do
    member do
      get :account
    end
  end

  resources :users, path: '', param: :username

  # mount API::Mount => '/'
  mount API::Mount => '/api'

end
