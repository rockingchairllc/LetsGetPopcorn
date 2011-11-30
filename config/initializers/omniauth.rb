
Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :facebook,'224567324265745', '29b03854dfc3afd54cce2af7ceed95d0',{:scope => 'publish_stream,offline_access,email'}
    
end