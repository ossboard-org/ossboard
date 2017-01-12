require './config/environment'
require 'omniauth'
require 'newrelic_rpm'
require 'newrelic-hanami'

NewRelic::Agent.manual_start

use Rack::Session::Cookie, secret: ENV['SESSIONS_SECRET']
use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], provider_ignores_state: true
end

if Hanami.env?(:development)
  require 'rack-mini-profiler'

  use Rack::MiniProfiler
end

run Hanami.app
