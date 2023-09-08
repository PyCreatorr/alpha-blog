Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'login', to: 'sessions#destroy'

  # get signup sends to the users controller and action new
  get 'signup', to: 'users#new' 

  resources :users, except: [:new]
  resources :articles#, only: [:show, :index, :new, :create, :edit, :update]

  root 'pages#home'
  get 'about', to: 'pages#about'


end
