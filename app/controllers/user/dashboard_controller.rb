class User::DashboardController < ApplicationController
  before_filter :authenticate_user!, :except => []

#For dashboard pages  
  def index
    # profile views
    @viewers = Profileview.find(:all, :conditions => "user_id = '#{current_user.id}'", :order =>"updated_at DESC")
  end

 # 2nd module overlay  
  def signup2
   @user = User.find(current_user.id, :include => :albums)
   
    synopses = Synopsis.find_by_user_id(current_user)
    
    unless synopses.nil?
      redirect_to :controller => "user/dashboard", :action => "index"
    else
   
        if request.post? and params[:users]
             if synopsis = Synopsis.new(params[:users])

               synopsis.title = "#{params[:users][:title]}"
               synopsis.user_id = "#{params[:users][:user_id]}"
               synopsis.supporting_actor = "#{params[:users][:supporting_actor]}"
               synopsis.status = "#{1}"
               
               synopsis.save

               redirect_to :controller => "user/dashboard", :action => "signup3"

             end
          end
     end
     @title ="profile"
   end
  
 # 3rd module overlay   
   def signup3
     
      favmovies = Favmovie.find_by_user_id(current_user)

      unless favmovies.nil?
        redirect_to :controller => "user/dashboard", :action => "index"
      else
     
           if request.post? and params[:users]
                if favmovie = Favmovie.new(params[:users])
                  
                  favmovie.height_feet = "#{params[:users][:height_feet]}"
                  favmovie.height_inches = "#{params[:users][:height_inches]}"
                  favmovie.smoke = "#{params[:users][:smoke]}"
                  favmovie.drink = "#{params[:users][:drink]}"
                  favmovie.title = "#{params[:users][:title]}"
                  favmovie.user_id = "#{params[:users][:user_id]}"
                  favmovie.status = "#{1}"
                  

                  favmovie.save

                  redirect_to :controller => "user/dashboard", :action => "index"

                end
             end
        end 
      @title ="profile"    
             
   end
  
  
end
