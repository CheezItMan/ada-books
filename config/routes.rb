Rails.application.routes.draw do

  root to: 'books#index'

  resources :genres, only: [:index, :show] do
    get '/books', to: 'books#index'
  end
  resources :books

  get '/login', to: 'sessions#login_form'
  post '/login', to: 'sessions#login'

  get "/auth/:provider/callback", to: 'sessions#create', as: 'auth_callback'

end
