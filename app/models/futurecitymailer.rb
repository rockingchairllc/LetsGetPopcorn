class Futurecitymailer < ActionMailer::Base
  
    def future_city_email(futurecity)
        setup_email(futurecity)
        @subject    += ""

      end

      protected
        def setup_email(futurecity)
          @recipients  = "kiplmailtest@gmail.com"
          @from        = "#{futurecity.email}"
          @subject     = "LetsGetPopcorn - Future City Demand: "
          @sent_on     = Time.now
          @content_type = "text/html"
          @body[:futurecity] = futurecity

       end
end
