CarrierWave.configure do |config|

  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIAIEAL4SJNEQ57EIPA',
      aws_secret_access_key: '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',
      region:                'ap-northeast-1', # Asia Pacific (Tokyo)
  }

  # if Rails.env.development?
  #   config.fog_directory  = 'photosdev'
  # elsif Rails.env.production?
  #   config.fog_directory  = 'photos'
  # end

  config.fog_public     = true
  config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
end