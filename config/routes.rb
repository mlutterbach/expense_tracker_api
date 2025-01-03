Rails.application.routes.draw do
  post '/signup', to: 'users#create'
  post '/signin', to: 'sessions#create'

  resources :expenses, only: [:index, :create, :update, :destroy] do
    collection do
      get :monthly_by_category
    end
  end
  resources :budgets, only: [:index, :create, :update, :destroy, :show]
end
