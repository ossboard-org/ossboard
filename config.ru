require './config/environment'
require 'omniauth'

use Rack::Session::Cookie, secret: ENV['SESSIONS_SECRET']
use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end

run Hanami.app
