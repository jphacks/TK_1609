CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => 'AKIAIYDHAYXCKDUJXADA',
    :aws_secret_access_key => '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',
    :region => 'ap-northeast-1',
    :path_style => true
  }

  config.fog_public     = true
  config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}

  config.fog_directory  = 'groove-storage'
end
