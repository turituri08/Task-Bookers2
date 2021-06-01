Rails.application.routes.draw do

 root to: "homes#top"
 get "/home/about" => "homes#about", as: "about"
 devise_for :users

 resources :books, only:[:index, :show, :edit, :update, :create, :update, :destroy] do
  resource :book_comments, only:[:create, :destroy]
  resource :favorites, only:[:create, :destroy]
 end

 resources :users, only:[:index, :show, :edit, :update]


end
