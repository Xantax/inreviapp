CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  }
  config.asset_host = "http://d2c0q6kxs6d400.cloudfront.net"
  #config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory = 'inreviapp'
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  #config.storage = :fog
end