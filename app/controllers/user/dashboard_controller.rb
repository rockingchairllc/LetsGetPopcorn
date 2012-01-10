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
  
  
end
