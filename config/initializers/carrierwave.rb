require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storagefog'

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['ap-northeast-1']
  }

  config.asset_host = ENV['S3_ASSET_HOST']

  config.fog_directory =
    case Rails.env
    when 'production'; then'AMIRY_production'
    when 'staging'; then 'AMIRY_staging'
    when 'development'; then 'AMIRY_development'
    else 'AMIRY_development'
    end

  config.storage = :file if Rails.env.test?
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
