require 'sidekiq'
require 'sidekiq-status'

Sidekiq::Extensions.enable_delay!

app_name = File.basename(Rails.root.to_s)

redis_domain =
  case Rails.env
  when 'production'  then ''
  when 'staging'     then ''
  when 'development' then 'localhost'
  when 'test'        then 'localhost'
  else 'localhost'
  end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_domain}:6379", namespace: "#{app_name}_#{Rails.env}" }
end

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis_domain}:6379", namespace: "#{app_name}_#{Rails.env}" }
end
