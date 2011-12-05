# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Moviewithme::Application.initialize!

OmniAuth.config.on_failure = Proc.new do |env|

end
