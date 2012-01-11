class Album < ActiveRecord::Base
  attr_accessible :user_id, :photo 
  belongs_to :user
  
  has_attached_file :photo, 
        :styles => { :thumb => "80x75" },
        
        :convert_options => {
              :thumb => "-background '#444444' -compose Copy -gravity center -extent 80x75"
          }
                      
end
