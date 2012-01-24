require 'rubygems'
require 'nokogiri'
require 'open-uri'

class PagesController < ApplicationController
  
  def movies
     time = Time.new 
      current_date = time.strftime("%Y%m%d")
      url = "http://api.tmsdatadirect.com/movies/MoviesInLocalTheatres?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&postalCode=10098&country=USA&date=#{current_date}&numDays=3&radius=50&radiusUnit=mi&rhDays=2"

        @doc = Nokogiri::HTML(open(url))
        
        @meta_title = " - Movies"
  end
  
  def matches
  end
  
  #  For Static Pages 
  def show
    @page = Page.find(params[:id])
    @meta_title = " - #{@page.title}"
  end
  
  #  For Contact-us 
  def contact
    @subject = Subject.all
    
    if request.post? and params[:contactus]
            if contact = Contact.new(params[:contactus])

              contact.name = "#{params[:contactus][:name]}"
              contact.email = "#{params[:contactus][:email]}"
              contact.subject = "#{params[:contactus][:subject]}"
              contact.message = "#{params[:contactus][:message]}"
              contact.save

             Emailer.deliver_contact_email(contact)

              flash[:notice] = "Thank you for sending a mail."
              redirect_to("/")

            end
         else
           @meta_title = " - Contact"
        end
    end
  
  
  
end
