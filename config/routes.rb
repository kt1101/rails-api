Rails.application.routes.draw do
  resources :users, only: [ :show, :update ]
  resources :jobs, except: [ :show ] do
    member do
      get :share_link, to: "jobs#share_link"
    end
  end

  scope "/auth" do
    post :signup, to: "auth#signup"
    post :login, to: "auth#login"
    delete :logout, to: "auth#logout"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
