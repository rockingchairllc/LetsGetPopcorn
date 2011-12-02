class PagesController < ApplicationController
  
  def movies
    @title = 'movies'
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
end
