require 'sidekiq'
require 'sidekiq-status'

Sidekiq::Extensions.enable_delay!

app_name = File.basename(Rails.root.to_s)

redis_domain =
  case Rails.env
  when 'production'; ''
  when 'staging'; ''
  when 'development'; 'localhost'
  when 'test'; 'localhost'
  else 'localhost'
  end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_domain}:6379", namespace: "#{app_name}_#{Rails.env}" }
end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://#{redis_domain}:6379', namespace: "#{app_name}_#{Rails.env}" }
end
