class User::AccountController < ApplicationController
  
  def index
    @title = 'account'
    @albums = current_user.albums.find(:all)
  end
  
end
