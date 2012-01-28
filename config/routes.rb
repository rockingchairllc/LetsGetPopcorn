Moviewithme::Application.routes.draw do |map|
  
  devise_for :admins, :path_names => { :sign_in =>"login", :sign_out =>"logout"}

  resources :authentications

  devise_for :users, :path_names => { :sign_up => "register", :sign_in =>"login", :sign_out =>"logout"}, 
  :controllers => { :registrations => "registrations" }

  
  map.connect '/movies', :controller=>'pages', :action=>'movies'
  map.connect '/matches', :controller=>'pages', :action=>'matches'
  map.connect '/contact', :controller=>'pages', :action=>'contact'
  match '/auth/:provider/callback' => 'authentications#create'
  map.connect '/pages/:id', :controller=>'pages', :action=>'show'
  map.connect '/edit/synopsis', :controller=>'user/account', :action=>'update_synopsis'
  map.connect '/edit/favmovie', :controller=>'user/account', :action=>'update_favmovie'
  map.connect '/edit/funnyque', :controller=>'user/account', :action=>'update_funnyque'
  
  root :to => "home#index"
  
  # User
  namespace :user do 
     match '/dashboard' => "dashboard#index", :as => :root
     match '/dashboard/signup/2' => "dashboard#signup2"
     match '/dashboard/signup/3' => "dashboard#signup3"
     match '/account' => "account#index"
     match '/albums/:id/delete'=> "albums#destroy"
     match '/albums/upload'=> "albums#upload_photo"
     resources :albums
     resources :synopses
     resources :favmovies
     resources :funnyques
   end
   
  # Administration
  namespace :admin do 
    match '/dashboard' => "dashboard#index", :as => :root
    resources :pages 
    resources :contacts
   end
  
end
