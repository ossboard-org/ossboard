# Require this file for feature tests
require_relative './spec_helper'

require 'capybara'
require 'capybara/rspec'
require_relative './support/capybara'

require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

Capybara.javascript_driver = :poltergeist

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  config.include RSpec::Hanami
  config.include RSpec::FeatureExampleGroup

  config.include Capybara::DSL,           feature: true
  config.include Capybara::RSpecMatchers, feature: true

  # show retry status in spec process
  config.verbose_retry = true
  # show exception that triggers a retry if verbose_retry is set to true
  config.display_try_failure_messages = true
  # only timeout exceptions triggers a retry
  config.exceptions_to_retry = [Capybara::Poltergeist::StatusFailError]
  # run retry only on features
  config.around(:each, :js) { |ex| ex.run_with_retry retry: 3 }
end

`cd #{Hanami.root} && webpack`
