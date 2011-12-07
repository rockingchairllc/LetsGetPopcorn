class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :strip_www

  def strip_www
    if request.env["HTTP_HOST"] == "letsgetpopcorn.com"
      redirect_to "http://www.letsgetpopcorn.com/"
    end
  end
    
end
