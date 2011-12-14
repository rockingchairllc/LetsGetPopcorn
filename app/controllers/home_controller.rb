class HomeController < ApplicationController
  def index
     if user_signed_in?
      redirect_to("/user/dashboard")
    else
    
    end
  end
end
