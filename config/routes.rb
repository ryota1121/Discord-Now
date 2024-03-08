Rails.application.routes.draw do
  root 'homes#top'
  get 'homes/about', to: 'homes#about', as: 'about'
  post 'homes/guest_login', to: 'homes#guest_login'
  
  get 'servers/new'
  get 'servers', to: 'servers#index'
  get 'servers/:id', to: 'servers#show', as: 'server'
  get 'servers/:id/edit', to: 'servers#edit', as: 'edit_server'
  post 'servers', to: 'servers#create'
  patch 'servers/:id' => 'servers#update', as: 'update_server'
  
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'log_out', to: 'sessions#destroy', as: 'log_out'

  resources :sessions, only: %i[create destroy]
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
