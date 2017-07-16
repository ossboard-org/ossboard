require 'dry-container'
require 'dry-auto_inject'

require_relative 'ossboard/core/markdown'
require_relative 'ossboard/core/http_request'
require_relative 'ossboard/services/analytic_reporter'

class Container
  extend Dry::Container::Mixin

  register('core.markdown', Core::Markdown.new)
  register('core.http_request', Core::HttpRequest)

  register('services.analytic_reporter', Services::AnalyticReporter.new)
end

Import = Dry::AutoInject(Container)
