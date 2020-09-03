Rails.application.routes.draw do
  get 'like/create'
  get 'like/destroy'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'category', to: 'coffees#category'
  get 'search', to: 'coffees#search'
  get 'liked_coffees/:id', to: 'coffees#liked_coffees', as: 'liked_coffees'
  get 'my_coffees/:id', to: 'coffees#my_coffees', as: 'my_coffees'
  get 'my_reviews/:id', to: 'coffees#my_reviews', as: 'my_reviews'

  resources :coffees do
    post 'toggle_like', to: 'likes#toggle'
    resources :reviews, only: [:create, :new, :update, :edit]
  end

  resources :users, only: [:index, :show, :update] do
    member do
      post :follow
      post :unfollow
    end
  end

  resources :reviews, only: [:index, :destroy] do
    resources :review_likes, only: [:create]
  end
  resources :review_likes, only: :destroy
end
