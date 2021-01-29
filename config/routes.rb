Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  
  resources :users, only: [:index, :new, :update, :create, :destroy, :show]
  
  resources :prototypes, only: [:new, :update, :create, :destroy, :show, :edit] do
    resources :comments, only: [:create]
  end
end
