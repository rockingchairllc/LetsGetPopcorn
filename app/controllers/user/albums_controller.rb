class User::AlbumsController < ApplicationController
  
  def new
    @album = current_user.albums.new
  end

  def create
    @album = current_user.albums.new(params[:album])
    if @album.save
      flash[:notice] = "Album created successfully"
      redirect_to("/user/account")
    else
      render :new
    end
  end
  
end
