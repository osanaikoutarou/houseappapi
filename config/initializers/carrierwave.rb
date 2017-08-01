CarrierWave.configure do |config|

  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY'],
      aws_secret_access_key: ENV['AWS_ACCESS_SECRET'],
      region: 'ap-northeast-1'
  }
  config.fog_directory = ENV['AWS_S3_BUCKET_NAME']

  # if Rails.env.development?
  #   config.fog_directory  = 'photosdev'
  # elsif Rails.env.production?
  #   config.fog_directory  = 'photos'
  # end

  config.fog_public     = true
  config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
end