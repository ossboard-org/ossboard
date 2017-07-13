require 'dry-container'
require 'dry-auto_inject'

require_relative 'ossboard/core/markdown'
require_relative 'ossboard/core/http_request'

class Container
  extend Dry::Container::Mixin
  register('core.markdown', Core::Markdown.new)
  register('core.http_request', Core::HttpRequest)
end
Import = Dry::AutoInject(Container)
