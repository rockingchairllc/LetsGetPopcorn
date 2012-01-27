class User::AccountController < ApplicationController
  
  before_filter :authenticate_user!, :except => []
  
  def index
    @meta_title = ' - account'
    @albums = current_user.albums.find(:all, :limit => 5)
    @favmovie = Favmovie.find_by_user_id(current_user)
    @funnyque = Funnyque.find_by_user_id(current_user)
    @synopse = Synopsis.find_by_user_id(current_user)
  end
  
  # Add and edit synopsis 
  def update_synopsis
    
    if request.post? and params[:users]
      @synopsis  = Synopsis.find_by_user_id(params[:users][:user_id])
      
      unless @synopsis.nil?
      
          if @synopsis.update_attributes(params[:users])
      
            render :update do |page|
              page.replace_html 'maindiv', :partial => 'user/account/synopsis'
            end
          end
      else
          
           @synopsis = Synopsis.new(params[:users])
         
           @synopsis.title = "#{params[:users][:title]}"
           @synopsis.user_id = "#{params[:users][:user_id]}"
           @synopsis.save
           
           render :update do |page|
             page.replace_html 'maindiv', :partial => 'user/account/synopsis'
           end
      end      
    end
  end
 
  # Add and edit favorite movie of all time  
  def update_favmovie
    
    if request.post? and params[:users]
      @favmovie  = Favmovie.find_by_user_id(params[:users][:user_id])
      
      unless @favmovie.nil?
      
          if @favmovie.update_attributes(params[:users])
      
            render :update do |page|
              page.replace_html 'maindiv2', :partial => 'user/account/favmovie'
            end
          end
      else
          
           @favmovie = Favmovie.new(params[:users])
         
           @favmovie.title = "#{params[:users][:title]}"
           @favmovie.user_id = "#{params[:users][:user_id]}"
           @favmovie.save
           
           render :update do |page|
             page.replace_html 'maindiv2', :partial => 'user/account/favmovie'
           end
      end      
    end
  end
  
   # Add and edit funny question  
  def update_funnyque
    
    if request.post? and params[:users]
      @funnyque  = Funnyque.find_by_user_id(params[:users][:user_id])
      
      unless @funnyque.nil?
      
          if @funnyque.update_attributes(params[:users])
      
            render :update do |page|
              page.replace_html 'maindiv3', :partial => 'user/account/funnyque'
            end
          end
      else
          
           @funnyque = Funnyque.new(params[:users])
         
           @funnyque.title = "#{params[:users][:title]}"
           @funnyque.user_id = "#{params[:users][:user_id]}"
           @funnyque.save
           
           render :update do |page|
             page.replace_html 'maindiv3', :partial => 'user/account/funnyque'
           end
      end      
    end
  end
  
end
