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

  register('services.analytic_reporter', Services::AnalyticReporter.new)
  register('services.github_issue_requester', Services::GithubIssueRequester.new)
  register('services.gitlab_issue_requester', Services::GitlabIssueRequester.new)
  register('services.points_calculator', Services::PointsCalculator.new)
  register('services.task_twitter', Services::TaskTwitter.new)
  register('services.url_shortener', Services::UrlShortener.new)

  register('matchers.git_host', Matchers::GitHost::Matcher)
end

Import = Dry::AutoInject(Container)
