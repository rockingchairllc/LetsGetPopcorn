class Album < ActiveRecord::Base
  
  belongs_to :user
  
        
              has_attached_file :photo, 
                    :styles => { :thumb => "80x75" },
                    
                    :convert_options => {
                          :thumb => "-background '#F7F4F4' -compose Copy -gravity center -extent 80x75"
                      }
                      
   has_friendly_id :name, :use_slug => true
                      
end
