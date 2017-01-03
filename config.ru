require './config/environment'
require 'omniauth'
require 'skylight'

use Skylight::Middleware

use Rack::Session::Cookie, secret: ENV['SESSIONS_SECRET']
use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], provider_ignores_state: true
end

run Hanami.app
