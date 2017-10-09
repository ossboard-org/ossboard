require 'dry/system/container'

class Container < Dry::System::Container
  namespace('core') do
    register('markdown_parser') { load! 'ossboard/core/markdown_parser' }
    register('http_request') { load! 'ossboard/core/http_request' }
  end

  namespace('services') do
    register('analytic_reporter') { load! 'ossboard/services/analytic_reporter' }
    register('points_calculator') { load! 'ossboard/services/points_calculator' }
    register('url_shortener')     { load! 'ossboard/services/url_shortener' }
    register('task_twitter')      { load! 'ossboard/services/task_twitter' }
  end

  namespace('tasks') do
    namespace('interactors') do
      register('create')            { Tasks::Interactors::Create }
      register('update')            { Tasks::Interactors::Update }
      register('update_status')     { Tasks::Interactors::UpdateStatus }
      register('issue_information') { Tasks::Interactors::IssueInformation }
    end

    namespace('services') do
      register('github_issue_requester') { load! 'tasks/services/github_issue_requester' }
      register('gitlab_issue_requester') { load! 'tasks/services/gitlab_issue_requester' }
    end

    register('matchers.git_host') do
      load_file! 'tasks/matchers/git_host'
      Tasks::Matchers::GitHost::Matcher
    end
  end

  def self.load_file!(path)
    require_relative "#{Hanami.root}/lib/#{path}"
  end

  def self.load!(path)
    load_file!(path)

    path.sub!('ossboard/', '')

    Object.const_get(Inflecto.classify(path)).new
  end

  configure 
end
