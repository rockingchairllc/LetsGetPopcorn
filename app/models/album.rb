class Album < ActiveRecord::Base
  
  belongs_to :user
  
  has_attached_file :photo, 
                    :styles => { :thumb => "60x50" },
                    
                    :convert_options => {
                          :thumb => "-background '#F7F4F4' -compose Copy -gravity center -extent 60x50"
                      }
                      
end
