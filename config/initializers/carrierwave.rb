CarrierWave.configure do |config|

  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIAJ7WGDVOY6ZC3FNHA',
      aws_secret_access_key: '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'
  }
  config.fog_directory = "houseapp-dev" # BUCKET NAME

  # if Rails.env.development?
  #   config.fog_directory  = 'photosdev'
  # elsif Rails.env.production?
  #   config.fog_directory  = 'photos'
  # end

  config.fog_public     = true
  config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
end