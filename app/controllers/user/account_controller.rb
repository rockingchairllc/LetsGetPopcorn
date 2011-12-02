class User::AccountController < ApplicationController
  
  before_filter :authenticate_user!, :except => []
  
  def index
    @title = 'account'
    @albums = current_user.albums.find(:all, :limit => 5)
  end
  
end
