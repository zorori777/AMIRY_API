require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'
require 'dotenv'

Dotenv.overload

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: 'ap-northeast-1'
  }

  config.asset_host = ENV['S3_ASSET_HOST']

  config.fog_directory =
    case Rails.env
    when 'production'; then'amiry-production'
    when 'staging'; then 'amiry-staging'
    when 'development'; then 'amiry-development'
    else 'amiry-development'
    end

  config.storage = :file if Rails.env.test?
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
