Rails.application.routes.draw do
  root to: 'pages#home'

  resources :chefs, except: [:new]

  resources :recipes do
    resources :comments, only: [:create]
    member do
      post 'like'
    end
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
