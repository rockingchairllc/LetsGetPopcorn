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

      time = Time.new 
      current_date = time.strftime("%Y%m%d")

      url = "http://api.tmsdatadirect.com/movies/MoviesInLocalTheatres?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&postalCode=10098&country=USA&date=#{current_date}&numDays=7&radius=100&radiusUnit=mi&rhDays=14"
      @doc = Nokogiri::HTML(open(url))

      url3 = "http://api.tmsdatadirect.com/movies/TheatresAndShowtimesByMovie?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&movieId=#{params[:id]}&postalCode=60611&country=USA&date=#{current_date}&numDays=7&numTheatres=&radius=100&radiusUnit=mi"
      @doc3 = Nokogiri::HTML(open(url3))

    end


    def showtime

      time = Time.new 
      current_date = time.strftime("%Y%m%d")

      url = "http://api.tmsdatadirect.com/movies/MoviesInLocalTheatres?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&postalCode=10098&country=USA&date=#{current_date}&numDays=7&radius=100&radiusUnit=mi&rhDays=14"
      @doc = Nokogiri::HTML(open(url))
      
      url3 = "http://api.tmsdatadirect.com/movies/TheatreShowtimes?rType=xml&srvcVersion=1.0&aid=rocking-4q7&key=K4w3s3D93NFg&theatreId=#{params[:theatreid]}&date=#{current_date}&numDays=7"
      @doc3 = Nokogiri::HTML(open(url3))

    end
    
    
    #Movie add into the watchlist
    def addtime
        
        if request.post? and params[:showtime]
          
          mymovie = Showtime.find(:all, :conditions => "movieid=#{params[:showtime][:movieid]} and user_id = #{params[:showtime][:user_id]}").count
          
          unless mymovie >= 2
            
              if showtime = Showtime.new(params[:showtime])
                showtime.seltime = "#{params[:showtime][:seltime]}"
                showtime.movieid = "#{params[:showtime][:movieid]}"
                showtime.theatreid = "#{params[:showtime][:theatreid]}"
                showtime.showdate = "#{params[:showtime][:showdate]}"
                showtime.user_id = "#{params[:showtime][:user_id]}"
                showtime.save

                flash[:notice] = "Movie added to your watchlist."
                redirect_to("/movies")
              end
           else
               flash[:notice] = "You can not add more than 2 watchlist for same movie." 
                redirect_to("/movies")
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
