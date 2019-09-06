Rails.application.routes.draw do
  namespace :admin do
    get "/", to: "base#index"
    resources :words, except: :show
    resources :courses, except: :show
    resources :users, except: :show
    resources :questions, except: :show
  end
  root "static_pages#home"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i(create destroy)
  resources :account_activations, only: :edit
  resources :courses, only: %(index)
  resources :excercises
  get "/course/:course_id/new", to: "excercises#new", as: "do_excercise"
  resources :password_resets, only: %i(new create edit update)
  get "/facebook/login", to: "facebooks#login_facebook", as: "login_facebook"
  resource :facebook
end
