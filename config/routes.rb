Rails.application.routes.draw do
  # devise_for :users, :controllers => { registrations: 'registrations'}
  root to: 'pages#home'

  resources :chefs, except: [:new]

  resources :recipes do
    collection do
      get 'search'
    end
    resources :comments, only: [:create]
  end

  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]
  resources :ingredients, except: [:destroy]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # post '/chefs' => 'chefs#new'

  mount ActionCable.server => '/cable'
  get '/chat', to: 'chatrooms#show'

  resources :messages, only: [:create]
end
