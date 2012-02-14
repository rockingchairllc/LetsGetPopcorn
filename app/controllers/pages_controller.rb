require 'rubygems'
require 'nokogiri'
require 'open-uri'

class PagesController < ApplicationController
  
before_filter :authenticate_user!, :except => [:movies, :matches, :show, :contact, :imdb, :watchlist, :showtime, :search]
  
  def movies
     time = Time.new 
      current_date = time.strftime("%Y%m%d")
      
       url = "http://api.tmsdatadirect.com/movies/MoviesInLocalTheatres?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&postalCode=10098&country=USA&date=#{current_date}&numDays=7&radius=100&radiusUnit=mi&rhDays=14"
         @doc = Nokogiri::HTML(open(url))
         @meta_title = " - Movies"
         
  end
  
  def matches
    time = Time.new
    current_date = time.strftime("%Y-%m-%d %H:%M:%S ")
    @matches = Showtime.find(:all, :conditions => "showdate >= '#{current_date}'")
  end
  
  def profile
    time = Time.new
    current_date = time.strftime("%Y-%m-%d %H:%M:%S ")
    
    @user = User.find(params[:id])
    @mymovies = Showmovie.find(:all, :conditions => "user_id= '#{@user.id}' and showdate >= '#{current_date}'")
    
    
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
    
    
    def watchlist
      
      
      unless params[:zip].nil?
        zip, miles = "#{params[:zip]}", "#{params[:miles]}"
      else
        zip, miles = "10098", "100"
      end

      time = Time.new 
      current_date = time.strftime("%Y%m%d")

      url = "http://api.tmsdatadirect.com/movies/MoviesInLocalTheatres?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&postalCode=#{zip}&country=USA&date=#{current_date}&numDays=7&radius=#{miles}&radiusUnit=mi&rhDays=14"
      @doc = Nokogiri::HTML(open(url))

      url3 = "http://api.tmsdatadirect.com/movies/TheatresAndShowtimesByMovie?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&movieId=#{params[:movieid]}&postalCode=#{zip}&country=USA&date=#{current_date}&numDays=7&numTheatres=&radius=#{miles}&radiusUnit=mi" 
      @doc3 = Nokogiri::HTML(open(url3))

    end


    def showtime
      
      unless params[:zip].nil?
        zip, miles = "#{params[:zip]}", "#{params[:miles]}"
      else
        zip, miles = "10098", "100"
      end

      time = Time.new 
      current_date = time.strftime("%Y%m%d")

      url = "http://api.tmsdatadirect.com/movies/MoviesInLocalTheatres?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&postalCode=#{zip}&country=USA&date=#{current_date}&numDays=7&radius=#{miles}&radiusUnit=mi&rhDays=14"
      @doc = Nokogiri::HTML(open(url))
      
      url3 = "http://api.tmsdatadirect.com/movies/TheatreShowtimes?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&theatreId=#{params[:theatreid]}&date=#{current_date}&numDays=7"
      @doc3 = Nokogiri::HTML(open(url3))

    end
    
    
    
    #Movie add into the watchlist
      def addtime

        time = Time.new
        current_date = time.strftime("%Y-%m-%d %H:%M:%S ")

          if request.post? and params[:showtime]


              mymovie = Showmovie.find(:all, :conditions => "user_id = #{params[:showtime][:user_id]} and showdate >= '#{current_date}'").count

              unless mymovie >= 2

                  showmovie = Showmovie.create(:movieid=> params[:showtime][:movieid], :showdate => params[:showtime][:showdate], :user_id => params[:showtime][:user_id])
                  showtime = Showtime.create(:movieid=> params[:showtime][:movieid], :theatreid => params[:showtime][:theatreid],  :showdate => params[:showtime][:showdate], :user_id => params[:showtime][:user_id])

                  flash[:notice] = "Movie added to your watchlist."
                  redirect_to("/movies/showtime?movieid=#{params[:showtime][:movieid]}&theatreid=#{params[:showtime][:theatreid]}")

              else

                  @cnt = Showmovie.find(:all, :conditions => "movieid = #{params[:showtime][:movieid]} and user_id = #{params[:showtime][:user_id]}")

                  unless @cnt.empty?
                    @cnt.each do |c|
                      showmovie = Showmovie.update(c.id, :movieid => c.movieid, :user_id => c.user_id, :showdate => params[:showtime][:showdate])
                    end
                    showtime = Showtime.create(:movieid => params[:showtime][:movieid], :theatreid => params[:showtime][:theatreid],  :showdate => params[:showtime][:showdate], :user_id => params[:showtime][:user_id])

                    flash[:notice] = "Movie added to your watchlist."
                    redirect_to("/movies/showtime?movieid=#{params[:showtime][:movieid]}&theatreid=#{params[:showtime][:theatreid]}")
                  else
                    flash[:notice] = "Love the enthusiasm! But, unfortunately, we can only handle 2 movies on your watchlist right now." 
                    redirect_to("/movies/showtime?movieid=#{params[:showtime][:movieid]}&theatreid=#{params[:showtime][:theatreid]}")
                  end
              end
          end

      end
    
    
    
    
    def search

      time = Time.new 
      current_date = time.strftime("%Y%m%d")

      url = "http://api.tmsdatadirect.com/movies/MoviesInLocalTheatres?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&postalCode=#{params[:search][:zip]}&country=USA&date=#{current_date}&numDays=7&radius=#{params[:search][:miles]}&radiusUnit=mi&rhDays=14"
       @doc = Nokogiri::HTML(open(url))
       @meta_title = " - Movies"
       
    end
  
  
  
end
