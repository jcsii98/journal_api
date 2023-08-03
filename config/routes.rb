Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'users/registrations'
  }

  # Defines the root path route ("/")

  root 'render#index'
end

