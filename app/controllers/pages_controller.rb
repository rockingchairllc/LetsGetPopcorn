require 'rubygems'
require 'nokogiri'
require 'open-uri'

class PagesController < ApplicationController
  
before_filter :authenticate_user!, :except => [:movies, :matches, :show, :contact, :imdb, :watchlist, :showtime, :search, :thankyou, :moreinfo, :thanks, :showday, :showtime, :map, :add_to_watchlist]
  
  def movies
     time = Time.new 
      current_date = time.strftime("%Y%m%d")
      
      if user_signed_in?
        @zip, @miles = "#{current_user.zip}", "5"
      else
        @zip, @miles = "10026", "5"
      end
      
       url = "http://api.tmsdatadirect.com/movies/MoviesInLocalTheatres?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&postalCode=#{@zip}&country=USA&date=#{current_date}&numDays=1&radius=#{@miles}&radiusUnit=mi&rhDays=14"
       # url = "temp/MoviesInLocalTheatres.xml"
          @doc = Nokogiri::HTML(open(url))
          @meta_title = " - Movies"
          
          @title = "movies"
  end
  
  def matches
    time = Time.new
    current_date = time.strftime("%Y-%m-%d %H:%M:%S ")
    @matches = Showtime.find(:all, :conditions => "showdate >= '#{current_date}'", :order =>"showdate ASC")
    @title = "matches"
  end
  
  def profile
    time = Time.new
    current_date = time.strftime("%Y-%m-%d %H:%M:%S ")
    
    @user = User.find(params[:id])
    @mymovies = Showmovie.find(:all, :conditions => "user_id= '#{@user.id}' and showdate >= '#{current_date}'")
    @title = "matches"
    
    # add new profileview entry
    profile_view = Profileview.new(:user_id => "#{@user.id}", :viewer_id => "#{current_user.id}")
    profile_view.save
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
    
   
    # View imdb sumary  
    def imdb

      url2 = "http://api.tmsdatadirect.com/movies/MovieSummary?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&movieId=#{params[:id]}&country=USA&lang=en"
      @doc2 = Nokogiri::HTML(open(url2))
      respond_to do |format|
            format.js { render :action => 'imdb' }
      end

    end
    
    def moreinfo
      
      url2 = "http://api.tmsdatadirect.com/movies/MovieSummary?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&movieId=#{params[:movieid]}&country=USA&lang=en"
      @doc2 = Nokogiri::HTML(open(url2))
      @title = "movies"
      
    end
    
    
    def watchlist
      
      if params[:search]
        zip, miles = "#{params[:search][:zip]}", "#{params[:search][:miles]}"
      else
        
        unless params[:zip].nil?
          zip, miles = "#{params[:zip]}", "#{params[:miles]}"
        else
          if user_signed_in?
            zip, miles = "#{current_user.zip}", "5"
          else
            zip, miles = "10026", "5"
          end
        end
      end

      time = Time.new 
      current_date = time.strftime("%Y%m%d")

      url = "http://api.tmsdatadirect.com/movies/MoviesInLocalTheatres?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&postalCode=#{zip}&country=USA&date=#{current_date}&numDays=1&radius=#{miles}&radiusUnit=mi&rhDays=14"
      @doc = Nokogiri::HTML(open(url))

      if params[:search]
          url3 = "http://api.tmsdatadirect.com/movies/TheatresAndShowtimesByMovie?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&movieId=#{params[:search][:movieid]}&postalCode=#{zip}&country=USA&date=#{current_date}&numDays=7&numTheatres=&radius=#{miles}&radiusUnit=mi" 
      else
          url3 = "http://api.tmsdatadirect.com/movies/TheatresAndShowtimesByMovie?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&movieId=#{params[:movieid]}&postalCode=#{zip}&country=USA&date=#{current_date}&numDays=7&numTheatres=&radius=#{miles}&radiusUnit=mi"
      end    
      @doc3 = Nokogiri::HTML(open(url3))
      @title = "movies"

    end


    def showtime
      
      unless params[:zip].empty?
        zip, miles = "#{params[:zip]}", "#{params[:miles]}"
      else
        if user_signed_in?
          zip, miles = "#{current_user.zip}", "5"
        else
          zip, miles = "10026", "5"
        end
      end

      time = Time.new 
      current_date = time.strftime("%Y%m%d")

      url = "http://api.tmsdatadirect.com/movies/MoviesInLocalTheatres?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&postalCode=#{zip}&country=USA&date=#{current_date}&numDays=1&radius=#{miles}&radiusUnit=mi&rhDays=14"
      @doc = Nokogiri::HTML(open(url))
      
      url3 = "http://api.tmsdatadirect.com/movies/TheatreShowtimes?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&theatreId=#{params[:theatreid]}&date=#{current_date}&numDays=1"
      @doc3 = Nokogiri::HTML(open(url3))
      @title = "movies"

    end
    
    
    
    #Movie add into the watchlist
      def addtime

        time = Time.new
        current_date = time.strftime("%Y-%m-%d %H:%M:%S ")

          if request.post? and params[:showtime]


              mymovie = Showmovie.select('DISTINCT movieid').find(:all, :conditions => "user_id = #{params[:showtime][:user_id]} and showdate >= '#{current_date}'").count

              unless mymovie >= 2

                  showmovie = Showmovie.create(:movieid=> params[:showtime][:movieid], :showdate => params[:showtime][:showdate], :user_id => params[:showtime][:user_id])
                  showtime = Showtime.create(:movieid=> params[:showtime][:movieid], :theatreid => params[:showtime][:theatreid],  :showdate => params[:showtime][:showdate], :user_id => params[:showtime][:user_id])

                  flash[:notice] = "Movie added to your watchlist."
                  redirect_to("/movies/showtime?miles=#{params[:showtime][:miles]}&movieid=#{params[:showtime][:movieid]}&theatreid=#{params[:showtime][:theatreid]}&zip=#{params[:showtime][:zip]}")

              else

                  @cnt = Showmovie.find(:all, :conditions => "movieid = #{params[:showtime][:movieid]} and user_id = #{params[:showtime][:user_id]}")

                  unless @cnt.empty?
                    @cnt.each do |c|
                        unless "#{c.showdate}" >=  "#{params[:showtime][:showdate]}"
                          myshowtime = "#{params[:showtime][:showdate]}"
                        else
                          myshowtime = "#{c.showdate}"
                        end
                        
                      showmovie = Showmovie.update(c.id, :movieid => c.movieid, :user_id => c.user_id, :showdate => myshowtime)
                    end
                    showtime = Showtime.create(:movieid => params[:showtime][:movieid], :theatreid => params[:showtime][:theatreid],  :showdate => params[:showtime][:showdate], :user_id => params[:showtime][:user_id])

                    flash[:notice] = "Movie added to your watchlist."
                    redirect_to("/movies/showtime?miles=#{params[:showtime][:miles]}&movieid=#{params[:showtime][:movieid]}&theatreid=#{params[:showtime][:theatreid]}&zip=#{params[:showtime][:zip]}")
                    
                  else
                    flash[:notice] = "Love the enthusiasm! But, unfortunately, we can only handle 2 movies on your watchlist right now." 
                    redirect_to("/movies/showtime?miles=#{params[:showtime][:miles]}&movieid=#{params[:showtime][:movieid]}&theatreid=#{params[:showtime][:theatreid]}&zip=#{params[:showtime][:zip]}")
                    
                 end
              end
          end

      end
    
    
    
    
    def search
      
        check_zip = Zipcode.find_by_codes(params[:search][:zip])
       
        unless check_zip.nil?

          time = Time.new 
          current_date = time.strftime("%Y%m%d")

          url = "http://api.tmsdatadirect.com/movies/MoviesInLocalTheatres?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&postalCode=#{params[:search][:zip]}&country=USA&date=#{current_date}&numDays=1&radius=#{params[:search][:miles]}&radiusUnit=mi&rhDays=14"
          @doc = Nokogiri::HTML(open(url))
          @meta_title = " - Movies"
          
        else
          redirect_to("/thanks")
        end
        
        @title = "movies"
       
    end
    
    def thankyou
    end
    
    def thanks
    end
  
  
    def showday

        unless params[:zip].empty?
          zip, miles = "#{params[:zip]}", "#{params[:miles]}"
        else
         
            if user_signed_in?
              zip, miles = "#{current_user.zip}", "5"
            else
              zip, miles = "10026", "5"
            end
          
        end

        time = Time.new 
        current_date = time.strftime("%Y%m%d")

        url3 = "http://api.tmsdatadirect.com/movies/TheatreShowtimes?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&theatreId=#{params[:theatreid]}&date=#{current_date}&numDays=1"
        @doc3 = Nokogiri::HTML(open(url3))
        
        render :update do |page|
              page.replace_html 'mydays', :partial => 'pages/showday'
        end

      end
      
      
      def showtime

          unless params[:zip].empty?
            zip, miles = "#{params[:zip]}", "#{params[:miles]}"
          else

              if user_signed_in?
                zip, miles = "#{current_user.zip}", "5"
              else
                zip, miles = "10026", "5"
              end

          end

          time = Time.new 
          current_date = time.strftime("%Y%m%d")

          url3 = "http://api.tmsdatadirect.com/movies/TheatreShowtimes?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&theatreId=#{params[:theatreid]}&date=#{current_date}&numDays=1"
          @doc3 = Nokogiri::HTML(open(url3))

          render :update do |page|
                page.replace_html 'mytime', :partial => 'pages/showtime'
          end

      end
      
    
    def add_to_watchlist
      
      unless params[:zip].nil?
        zip, miles = "#{params[:zip]}", "#{params[:miles]}"
      else
        if user_signed_in?
          zip, miles = "#{current_user.zip}", "5"
        else
          zip, miles = "10026", "5"
        end
      end

      time = Time.new 
      current_date = time.strftime("%Y%m%d")

      url = "http://api.tmsdatadirect.com/movies/MoviesInLocalTheatres?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&postalCode=#{zip}&country=USA&date=#{current_date}&numDays=1&radius=#{miles}&radiusUnit=mi&rhDays=14"
      @doc = Nokogiri::HTML(open(url))
      
      url2 = "http://api.tmsdatadirect.com/movies/MovieSummary?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&movieId=#{params[:movieid]}&country=USA&lang=en"
      @doc2 = Nokogiri::HTML(open(url2))
      
      
    end


    def map
    end
    
  
end
