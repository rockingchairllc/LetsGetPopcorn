
Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :facebook,'146261058813526', '59252c9bf43e22a8bdff70f5e030cd84',{:scope => 'publish_stream,offline_access,email'}
    
end