CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: 'AKIAIGCJKAUC3OHB6ATA',
    aws_secret_access_key: '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'
  }
  config.asset_host = "http://d29puu9ttvyqql.cloudfront.net"
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory = 'inreviapp'
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  config.storage = :fog
end