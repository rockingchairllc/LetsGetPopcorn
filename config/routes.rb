Moviewithme::Application.routes.draw do |map|
  devise_for :users

  map.connect '/movies', :controller=>'pages', :action=>'movies'
  root :to => "home#index"
  
  namespace :user do 
     match '/account' => "account#index", :as => :root
   end
  
end
