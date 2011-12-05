class OmniauthController < Devise::OmniauthCAllbacksController

   def failure
      #handle you logic here..
      #and delegate to super.
      super
   end
end

