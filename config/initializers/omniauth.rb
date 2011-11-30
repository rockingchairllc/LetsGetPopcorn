
Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :facebook,'191637837589329', '3f7d39f10457e62a53d2bf2825002010',{:scope => 'publish_stream,offline_access,email'}
    
end