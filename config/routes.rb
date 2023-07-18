Rails.application.routes.draw do
  # Defines the root path route ("/")
  # root "articles#index"

  get '/auth/current' => 'auth#current'
  post '/auth/signup' => 'auth#signup'
  post '/auth/signin' => 'auth#signin'
  post '/auth/signout' => 'auth#signout'
  
  
    resources :categories do
      resources :tasks
    end

  # Routes for categories 
  get '/categories' => 'categories#index'
  get '/categories/new' => 'categories#new', as: 'new_category'
  post '/categories' => 'categories#create', as: 'create_category'
  get '/categories/:id' => 'categories#show', as: 'show_category'
  delete '/categories/:id' => 'categories#destroy', as: 'delete_category'
  put '/categories/:id' => 'categories#update', as: 'update_category'

  # tasks for today
  get '/categories/tasks/due_today', to: 'tasks#due_today'
end

