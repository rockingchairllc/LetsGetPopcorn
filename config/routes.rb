Moviewithme::Application.routes.draw do |map|
  devise_for :admins

  resources :authentications

  devise_for :users

  map.connect '/movies', :controller=>'pages', :action=>'movies'
  match '/auth/:provider/callback' => 'authentications#create'
  root :to => "home#index"
  
  # User
  namespace :user do 
     match '/account' => "account#index", :as => :root
   end
   
  # Administration
  namespace :admin do 
    match '/dashboard' => "dashboard#index", :as => :root
    resources :pages 
    resources :contacts
   end
  
end
