Rails.application.routes.draw do
  root 'home#index'

  mount API::Mount => '/api'
end
