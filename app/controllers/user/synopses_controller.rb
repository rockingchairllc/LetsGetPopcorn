class User::SynopsesController < ApplicationController
  
  before_filter :authenticate_user!, :except => []
  
  def new
    @synopsis = current_user.synopses.new
  end

  def create
    @synopsis = current_user.synopses.new(params[:synopsis])
    if @synopsis.save
      flash[:notice] = "synopsis created successfully"
      redirect_to("/user/account")
    else
      render :new
    end
  end
  
  def edit
    @synopsis = current_user.synopses.find(params[:id])
  end

  def update
    @synopsis = current_user.synopses.find(params[:id])
    if @synopsis.update_attributes(params[:synopsis])
      flash[:notice] = "synopsis saved successfully"
      redirect_to("/user/account")
    else
      render :edit
    end
  end
  
end
