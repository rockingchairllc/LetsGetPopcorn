class Album < ActiveRecord::Base
  attr_accessible :user_id, :photo 
  belongs_to :user
  
  has_attached_file :photo, 
        :styles => { :thumb => "80x75" },
        :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
        :path => "reel/:id/:style/:basename.:extension",
        :convert_options => {
              :thumb => "-background '#444444' -compose Copy -gravity center -extent 80x75"
          }
                      
end
