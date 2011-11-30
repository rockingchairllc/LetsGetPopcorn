Moviewithme::Application.routes.draw do |map|
  resources :authentications

  devise_for :users

  map.connect '/movies', :controller=>'pages', :action=>'movies'
  match '/auth/:provider/callback' => 'authentications#create'
  root :to => "home#index"
  
  namespace :user do 
     match '/account' => "account#index", :as => :root
   end
  
end
