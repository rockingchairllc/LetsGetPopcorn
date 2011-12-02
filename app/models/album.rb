class Album < ActiveRecord::Base
  
  belongs_to :user
  
        
              has_attached_file :photo, 
                    :styles => { :thumb => "80x75" },
                    :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => "reel/:id/:style/:basename.:extension",
                    
                    :convert_options => {
                          :thumb => "-background '#F7F4F4' -compose Copy -gravity center -extent 80x75"
                      }
                      
   has_friendly_id :name, :use_slug => true
                      
end
