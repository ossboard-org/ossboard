require 'dry-container'
require 'dry-auto_inject'

class Container
  ContainerPath = File.dirname(__FILE__)
  extend Dry::Container::Mixin

  namespace('core') do
    register('markdown_parser') do
      load_file! 'ossboard/core/markdown_parser'
      Core::MarkdownParser.new
    end
    register('http_request') do
      load_file! 'ossboard/core/http_request'
      Core::HttpRequest.new
    end
  end

  namespace('services') do
    register('analytic_reporter') do
      load_file! 'ossboard/services/analytic_reporter'
      Services::AnalyticReporter.new
    end
    register('points_calculator') do
      load_file! 'ossboard/services/points_calculator'
      Services::PointsCalculator.new
    end
    register('url_shortener') do
      load_file! 'ossboard/services/url_shortener'
      Services::UrlShortener.new
    end
    register('task_twitter') do
      load_file! 'ossboard/services/task_tweeter'
      Services::TaskTwitter.new
    end
  end

  namespace('tasks') do
    namespace('interactors') do
      register('create') { Tasks::Interactors::Create }
      register('update') { Tasks::Interactors::Update }
      register('update_status') { Tasks::Interactors::UpdateStatus }
      register('issue_information') { Tasks::Interactors::IssueInformation }
    end

    namespace('services') do
      register('github_issue_requester') do
        load_file! 'tasks/services/github_issue_requester'
        Tasks::Services::GithubIssueRequester.new
      end
      register('gitlab_issue_requester') do
        load_file! 'tasks/services/gitlab_issue_requester'
        Tasks::Services::GitlabIssueRequester.new
      end
    end

    register('matchers.git_host') do
      load_file! 'tasks/matchers/git_host'
      Tasks::Matchers::GitHost::Matcher
    end
  end

  def self.load_file!(path)
    container_path = File.dirname(__FILE__)
    require_relative "#{container_path}/#{path}"
  end
end
Import = Dry::AutoInject(Container)
