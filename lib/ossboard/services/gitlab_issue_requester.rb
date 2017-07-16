module Services
  class GitlabIssueRequester
    def call(params)
      issue_data(params)
        .fmap { |data| data.merge(repo_data(params)) }
        .value
    end

  private

    GITLAB_REPO_API_URL = 'https://gitlab.com/api/v3/projects/%{org}%%2F%{repo}'.freeze
    GITLAB_ISSUE_API_URL = 'https://gitlab.com/api/v3/projects/%{org}%%2F%{repo}/issues/?iid=%{issue}'.freeze

    MESSAGE_KEY = 'message'.freeze
    ERROR_HASH = { error: 'invalid url' }
    ERROR_UNATHORIZED_HASH = { error: 'Unauthorized' }
    COMPLEXITY_LABELS = %w(easy medium hard).freeze

    def issue_data(params)
      response = get_response(GITLAB_ISSUE_API_URL % params)
      return M.Left(parse_errors(response)) unless response.is_a?(Net::HTTPSuccess)

      data = JSON.parse(response.body)
      return M.Left(ERROR_HASH) unless Array(data).size == 1

      data = data.first
      M.Right(
        html_url: data['web_url'],
        title: data['title'],
        body: data['description'],
        complexity: issue_complexity(data)
      )
    end

    def issue_complexity(data)
      labels = data['labels'].map!(&:downcase)
      labels.find { |label| COMPLEXITY_LABELS.include?(label) }
    end

    def repo_data(params)
      response = get_response(GITLAB_REPO_API_URL % params)
      data = JSON.parse(response.body)
      return {} unless response.is_a?(Net::HTTPSuccess)

      result = { repository_name: data['name'] }
      result
    end

    def parse_errors(issue_response)
      response_data = JSON.parse(issue_response.body)
      response_data.fetch(MESSAGE_KEY, {}).include?("Unauthorized") ?
        ERROR_UNATHORIZED_HASH : ERROR_HASH
    end

    def get_response(url)
      Container['core.http_request'].new(url).get do |request|
        request['PRIVATE-TOKEN'] = ENV['GITLAB_PRIVATE_TOKEN']
      end
    end
  end
end
