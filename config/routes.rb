Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users

  delete "/auth/logout", to: "auth#logout"
  post "/auth/login", to: "auth#login"
end
