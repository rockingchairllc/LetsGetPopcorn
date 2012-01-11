class User::AlbumsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:new, :create]
  
  def new
    @album = Album.new
    @meta_title = ' - Add album'
  end

  def create
    
    newparams = coerce(params)
    @album = Album.new(newparams[:album])
    if @album.save
      flash[:notice] = "Successfully created upload."
      respond_to do |format|
        format.html {redirect_to @album.user}
        format.json {render :json => { :result => 'success', :upload => user_album_path(@album) } }
      end
    else
      render :action => 'new'
    end
    
  end
  
  def edit
    @album = current_user.albums.find(params[:id])
    @meta_title = ' - Edit album'
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
  
  def show
     @album = Album.find(params[:id], :include => :user)
     @total_uploads = Album.find(:all, :conditions => { :user_id => @album.user.id})
  end
  
  # DELETE /album/1
  # DELETE /albums/1.xml
  def destroy
    @album = Album.find(params[:id])
    @user = User.find(@album.user_id)
    @album.destroy
    render(:update) do |page|
      page.replace_html 'photos_count', "#{pluralize(@user.albums.size, "Photo")}"
      page.replace_html 'uploads', :partial => @user.albums        
    end
  end
  
  private 
  def coerce(params)
    if params[:album].nil? 
      h = Hash.new 
      h[:album] = Hash.new 
      h[:album][:user_id] = params[:user_id]
      h[:album][:photo] = params[:Filedata] 
      h[:album][:photo].content_type = MIME::Types.type_for(h[:album][:photo].original_filename).to_s
      h
    else 
      params
    end 
  end
 
end
