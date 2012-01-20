class Useremailer < ActionMailer::Base
  
  def welcome_email(resources)
        setup_email(resources)
        @subject    += ""

      end

      protected
        def setup_email(resources)
          @recipients  = "#{resources.email}"
          @from        = "kiplmailtest@gmail.com"
          @subject     = "LetsGetPopcorn - User Registration: "
          @sent_on     = Time.now
          @content_type = "text/html"
          @body[:resources] = resources

        end
        
end
