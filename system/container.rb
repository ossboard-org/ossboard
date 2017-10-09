require 'dry/system/container'
require_relative 'resolver'

class Container < Dry::System::Container
  extend Dry::Hanami::Resolver

  register_folder! 'ossboard/core'
  register_folder! 'ossboard/services'

  namespace('tasks') do
    namespace('interactors') do
      register('create')            { Tasks::Interactors::Create }
      register('update')            { Tasks::Interactors::Update }
      register('update_status')     { Tasks::Interactors::UpdateStatus }
      register('issue_information') { Tasks::Interactors::IssueInformation }
    end

    register('matchers.git_host') do
      load_file! 'tasks/matchers/git_host'
      Tasks::Matchers::GitHost::Matcher
    end
  end
  register_folder! 'tasks/services'

  configure
end
