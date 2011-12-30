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
