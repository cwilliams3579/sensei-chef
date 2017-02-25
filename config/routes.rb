Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations'}
  resources :chefs

  resources :recipes do
    collection do
      get 'search'
    end
  end

  root to: 'pages#home'

  post '/users' => 'devise/registrations#new'
end
