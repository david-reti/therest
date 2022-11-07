Rails.application.routes.draw do
  resources :comments
  root "articles#index"
  
  get '/signin', to: 'users#signin', as: 'signin' 
  get '/signout', to: 'sessions#destroy', as: 'signout'
  get '/about', to: 'info#about', as: 'about'
  get '/privacy', to: 'info#privacy', as: 'privacy_policy'
  resources :lists, :articles
  resources :users do
    member do
      get 'profile'
    end
  end
  
  resource :session, only: [ :create ]
  resources :cities, only: [ :index, :get ]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
