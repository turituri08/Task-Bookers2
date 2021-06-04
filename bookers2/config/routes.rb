Rails.application.routes.draw do

 root to: "homes#top"
 get "/home/about" => "homes#about", as: "about"
 get "searches/search" => "searches#search", as: "search"
 devise_for :users

 resources :books, only:[:index, :show, :edit, :update, :create, :update, :destroy] do
  resource :book_comments, only:[:create, :destroy]
  resource :favorites, only:[:create, :destroy]
 end

 resources :users, only:[:index, :show, :edit, :update]
 resources :relationships, only: [:create, :destroy]
 resources :messages, only: [:create]
 resources :rooms, only: [:create,:show]
 get "relationships/followings/:id" => "relationships#followings", as: "followings"
 get "relationships/followers/:id" => "relationships#followers", as: "followers"
end
