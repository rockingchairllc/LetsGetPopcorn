class User::DashboardController < ApplicationController
  before_filter :authenticate_user!, :except => []
  
  def index
  end
  
  def signup2
   @user = User.find(current_user.id, :include => :albums)
   
        if request.post? and params[:users]
             if synopsis = Synopsis.new(params[:users])

               synopsis.title = "#{params[:users][:title]}"
               synopsis.user_id = "#{params[:users][:user_id]}"
               synopsis.supporting_actor = "#{params[:users][:supporting_actor]}"
               
               synopsis.save

               redirect_to("/")

             end
          end
   end
   
   def signup3
     
          

           if request.post? and params[:users]
                if favmovie = Favmovie.new(params[:users])
                  
                  favmovie.height_feet = "#{params[:users][:height_feet]}"
                  favmovie.height_inches = "#{params[:users][:height_inches]}"
                  favmovie.smoke = "#{params[:users][:smoke]}"
                  favmovie.drink = "#{params[:users][:drink]}"
                  favmovie.title = "#{params[:users][:favorite_movies]}"
                  favmovie.user_id = "#{params[:users][:user_id]}"
                  

                  favmovie.save

                  redirect_to("/")

                end
             end
             
   end
  
  
end
