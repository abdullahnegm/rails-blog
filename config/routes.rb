Rails.application.routes.draw do
  devise_for :users
  get '/profile', to: 'users#profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "posts#index"

  post "/payment", to: "payments#create"

  resources :messages, only: [:create, :new]
  resources :conversations, only: [:index, :show]
  resources :users, only: %i[index]

  resources :posts, except: [:index] do 
    resources :comments, only: [:create]
  end

  resources :fav_posts do 
    collection do
      get :favourite
      get :unfavourite
    end
  end

  mount ActionCable.server => '/cable'
end
