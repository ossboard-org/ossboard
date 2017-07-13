require 'dry-container'
require 'dry-auto_inject'
require_relative 'ossboard/core/markdown'

class Container
  extend Dry::Container::Mixin
  register('core.markdown', OSSBoard::Markdown.new)
end
Import = Dry::AutoInject(Container)
