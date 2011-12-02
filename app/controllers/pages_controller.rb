class PagesController < ApplicationController
  
  def movies
    @title = 'movies'
  end
  
  #  For Static Pages 
  def show
    @page = Page.find(params[:id])
  end
  
  #  For Contact-us 
  def contact
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
           @title = "contacts"
        end
  end
  
end
