class PagesController < ApplicationController
  
  def movies
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
    
    if request.post? and params[:reset_password]
            if contact = Contact.new(params[:reset_password])

              contact.name = "#{params[:reset_password][:name]}"
              contact.email = "#{params[:reset_password][:email]}"
              contact.subject = "#{params[:reset_password][:subject]}"
              contact.message = "#{params[:reset_password][:message]}"
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
