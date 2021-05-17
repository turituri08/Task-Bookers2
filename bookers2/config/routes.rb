Rails.application.routes.draw do

 root to: "homes#top"
 get "homes/about" => "homes#about", as: "about"
 devise_for :users

 resources :books, only:[:index, :show, :edit, :update, :create, :update, :destroy]
 resources :users, only:[:index, :show, :edit, :update]

end
