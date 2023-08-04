Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'users/registrations'
  }

  # Defines the root path route ("/")
  root 'render#index'


  # Routes for categories 
  get '/categories' => 'categories#index'
  get '/categories/new' => 'categories#new', as: 'new_category'
  post '/categories' => 'categories#create', as: 'create_category'
  get '/categories/:id' => 'categories#show', as: 'show_category'
  delete '/categories/:id' => 'categories#destroy', as: 'delete_category'
  put '/categories/:id' => 'categories#update', as: 'update_category'

  resources :categories do
    resources :tasks
  end

   # tasks for today
  get '/categories/tasks/due_today', to: 'tasks#due_today'


end

