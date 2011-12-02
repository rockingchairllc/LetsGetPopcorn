class User::AlbumsController < ApplicationController
  before_filter :authenticate_user!, :except => []
  
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
  
  def edit
    @album = current_user.albums.find(params[:id])
  end

  def update
    @album = current_user.albums.find(params[:id])
    if @album.update_attributes(params[:album])
      flash[:notice] = "Album saved successfully"
      redirect_to("/user/account")
    else
      render :edit
    end
  end
  
end
