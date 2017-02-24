Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations'}
  resources :chefs 
  resources :recipes

  root to: 'pages#home'
end
