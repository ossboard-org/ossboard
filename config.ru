require './config/environment'
require 'omniauth'
require 'newrelic_rpm'
require 'newrelic-hanami'

NewRelic::Agent.manual_start

use SecureHeaders::Middleware
use Rack::Session::Cookie, secret: ENV['SESSIONS_SECRET']

class Omniauth::Strategies::GithubAdmin < Omniauth::Strategies::Github
end

OmniAuth.config.add_camelization 'github_admin', 'GithubAdmin'
use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], provider_ignores_state: true
  provider :github_admin, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user,repo,gist", provider_ignores_state: true
end

if Hanami.env?(:development)
  require 'rack-mini-profiler'

  Rack::MiniProfiler.config.disable_caching = false
  Rack::MiniProfiler.config.storage = Rack::MiniProfiler::FileStore
  Rack::MiniProfiler.config.storage_options = { path: './tmp' }
  Rack::MiniProfiler.profile_method(Hanami::View::Rendering::Partial, :render) { "Render partial #{@options[:partial]}" }

  use Rack::MiniProfiler
end

run Hanami.app
