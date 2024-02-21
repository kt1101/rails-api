Rails.application.routes.draw do
  resources :jobs
  resources :users do
    put :update_avatar, on: :member
  end


  delete "/auth/logout", to: "auth#logout"
  post "/auth/login", to: "auth#login"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
