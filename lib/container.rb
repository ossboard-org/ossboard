require 'dry-container'
require 'dry-auto_inject'

%w[markdown http_request].each { |file| require_relative "ossboard/core/#{file}" }

%w[
  analytic_reporter github_issue_requester url_shortener
  gitlab_issue_requester points_calculator task_tweeter
].each { |file| require_relative "ossboard/services/#{file}" }

require_relative 'ossboard/matchers/git_host_matcher'

class Container
  extend Dry::Container::Mixin

  register('core.markdown', Core::Markdown.new)
  register('core.http_request', Core::HttpRequest.new)

  namespace('services') do
    register('analytic_reporter', Services::AnalyticReporter.new)
    register('github_issue_requester', Services::GithubIssueRequester.new)
    register('gitlab_issue_requester', Services::GitlabIssueRequester.new)
    register('points_calculator', Services::PointsCalculator.new)
    register('task_twitter', Services::TaskTwitter.new)
    register('url_shortener', Services::UrlShortener.new)
  end

  register('matchers.git_host', Matchers::GitHost::Matcher)

  namespace('tasks') do
    namespace('interactors') do
      register('create') { Tasks::Interactors::Create }
      register('update_status') { Tasks::Interactors::UpdateStatus }
      register('issue_information') { Tasks::Interactors::IssueInformation }
    end
  end
end

Import = Dry::AutoInject(Container)
