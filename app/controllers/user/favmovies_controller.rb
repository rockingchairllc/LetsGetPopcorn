class User::FavmoviesController < ApplicationController
  
  before_filter :authenticate_user!, :except => []
  
  def new
    @favmovie = current_user.favmovies.new
  end

  def create
    @favmovie = current_user.favmovies.new(params[:favmovie])
    if @favmovie.save
      flash[:notice] = "favmovie created successfully"
      redirect_to("/user/account")
    else
      render :new
    end
  end
  
  def edit
    @favmovie = current_user.favmovies.find(params[:id])
  end

  def update
    @favmovie = current_user.favmovies.find(params[:id])
    if @favmovie.update_attributes(params[:favmovie])
      flash[:notice] = "favmovie saved successfully"
      redirect_to("/user/account")
    else
      render :edit
    end
  end
  
end
