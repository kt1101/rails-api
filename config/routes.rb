# frozen_string_literal: true

Rails.application.routes.draw do
  resources :applicants, only: %i[index create update]
  resources :locations
  resources :users, only: %i[show update]
  resources :jobs, except: [:show] do
    member do
      get :share_link, to: 'jobs#share_link'
    end
  end

  scope '/auth' do
    post :signup, to: 'auth#signup'
    post :login, to: 'auth#login'
    delete :logout, to: 'auth#logout'
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener_web' if Rails.env.development?

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
