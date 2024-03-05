Rails.application.routes.draw do
  root 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'
  post 'homes/guest_login', to: 'homes#guest_login'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'log_out', to: 'sessions#destroy', as: 'log_out'

  resources :sessions, only: %i[create destroy]
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
