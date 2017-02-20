# Require this file for feature tests
require_relative './spec_helper'

require 'capybara'
require 'capybara/rspec'

require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 10

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  config.include RSpec::Hanami
  config.include RSpec::FeatureExampleGroup

  config.include Capybara::DSL,           feature: true
  config.include Capybara::RSpecMatchers, feature: true
end

`cd #{Hanami.root} && webpack`
