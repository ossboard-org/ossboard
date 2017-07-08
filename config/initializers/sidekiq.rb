require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.redis = OSSBoard::Application[:redis]
end

Sidekiq.configure_client do |config|
  config.redis = OSSBoard::Application[:redis]
end
