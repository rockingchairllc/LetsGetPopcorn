class User::AccountController < ApplicationController
  
  before_filter :authenticate_user!, :except => []
  
  def index
    @title = 'account'
    @albums = current_user.albums.find(:all, :limit => 5)
    @favmovie = Favmovie.find_by_user_id(current_user)
    @funnyque = Funnyque.find_by_user_id(current_user)
    @synopse = Synopsis.find_by_user_id(current_user)
  end
  
end
