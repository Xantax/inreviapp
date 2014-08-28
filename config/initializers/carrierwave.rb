CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: 'AKIAIGCJKAUC3OHB6ATA',
    aws_secret_access_key: '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'
  }
  config.asset_host = "d29puu9ttvyqql.cloudfront.net"
  config.fog_directory = 'inreviapp'
end