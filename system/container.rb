require 'dry/system/container'
require_relative 'resolver'

class Container < Dry::System::Container
  extend Dry::Hanami::Resolver

  #  Core
  register_folder! 'ossboard/repositories'
  register_folder! 'ossboard/core'
  register_folder! 'ossboard/services'

  # Tasks domain
  register_folder! 'tasks/services'
  register_folder! 'tasks/operations'
  register_folder! 'tasks/interactors', resolver: ->(k) { k }
  register_folder! 'tasks/matchers', resolver: ->(k) { k::Matcher }

  configure
end
