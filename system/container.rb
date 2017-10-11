require 'dry/system/container'
require_relative 'resolver'

class Container < Dry::System::Container
  extend Dry::Hanami::Resolver

  #  Core
  register_folder! 'ossboard/repositories'
  register_folder! 'ossboard/core'
  register_folder! 'ossboard/services'
  # register_folder! 'ossboard/workers', resolver: ->(k) { k }

  # Tasks domain
  register_folder! 'tasks/services'
  register_folder! 'tasks/interactors', resolver: ->(k) { k }

  register('tasks.matchers.git_host') do
    load_file! 'tasks/matchers/git_host'
    Tasks::Matchers::GitHost::Matcher
  end

  configure
end
