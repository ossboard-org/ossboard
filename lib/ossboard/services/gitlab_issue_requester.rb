require_relative '../../http_request'

class GitlabIssueRequester
  def self.call(params)
    new.call(params)
  end

  def call(params)
    success, data = issue_data(params)
    return data unless success

    success, repo = repo_data(params)
    return data unless success

    data.merge(repo)
  end

  private

  GITLAB_REPO_API_URL = 'https://gitlab.com/api/v3/projects/%{org}%%2F%{repo}'.freeze
  GITLAB_ISSUE_API_URL = 'https://gitlab.com/api/v3/projects/%{org}%%2F%{repo}/issues/?iid=%{issue}'.freeze

  MESSAGE_KEY = 'message'.freeze
  ERROR_HASH = { error: 'invalid url' }.freeze
  ERROR_UNATHORIZED_HASH = { error: 'Unauthorized' }.freeze
  LABEL_COMPLEXITY_NAMES = %w(easy medium hard).freeze

  def issue_data(params)
    response = get_response(GITLAB_ISSUE_API_URL % params)
    return [false, parse_errors(response)] unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    return [false, ERROR_HASH] unless Array(data).size == 1

    data = data.first
    result = {
      html_url: data['web_url'],
      title: data['title'],
      body: data['description'],
      complexity: issue_complexity(data)
    }

    [true, result]
  end

  def issue_complexity(data)
    labels = data['labels'].map(&:downcase)
    return unless labels

    labels.find { |label| LABEL_COMPLEXITY_NAMES.include?(label) }
  end

  def repo_data(params)
    response = get_response(GITLAB_REPO_API_URL % params)
    data = JSON.parse(response.body)
    return [false, {}] unless response.is_a?(Net::HTTPSuccess)

    result = { repository_name: data['name'] }
    [true, result]
  end

  def parse_errors(issue_response)
    response_data = JSON.parse(issue_response.body)
    response_data.fetch(MESSAGE_KEY, {}).include?("Unauthorized") ?
      ERROR_UNATHORIZED_HASH : ERROR_HASH
  end

  def get_response(url)
    HttpRequest.new(url).get do |request|
      request['PRIVATE-TOKEN'] = ENV['GITLAB_PRIVATE_TOKEN']
    end
  end
end
