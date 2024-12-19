Rails.application.routes.draw do
  post '/signup', to: 'users#create'
  post '/signin', to: 'sessions#create'

  resource :expenses, only: [:index, :create, :update, :destroy]
end
