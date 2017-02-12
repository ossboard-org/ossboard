require_relative '../../http_request'

class GithubIssueRequester
  def self.call(params)
    new.call(params)
  end

  def call(params)
    issue_data(params)
      .fmap { |data| data.merge(repo_data(params)) }
      .value
  end

  private

  ERROR_HASH = { error: 'invalid url' }.freeze

  GITHUB_REPO_API_URL = 'https://api.github.com/repos/%{org}/%{repo}'.freeze
  GITHUB_ISSUE_API_URL = 'https://api.github.com/repos/%{org}/%{repo}/issues/%{issue}'.freeze
  LABEL_COMPLEXITY_NAMES = %w(easy medium hard).freeze

  def get_response(url)
    HttpRequest.new(url).get
  end

  def issue_data(params)
    response = get_response(GITHUB_ISSUE_API_URL % params)
    return M.Left(ERROR_HASH) unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    M.Right(
      html_url: data['html_url'],
      title: data['title'],
      body: data['body'],
      complexity: issue_complexity(data)
    )
  end

  def issue_complexity(data)
    labels = data['labels']
    return unless labels
    labels.map { |label| label['name'].downcase }
          .find { |label_name| LABEL_COMPLEXITY_NAMES.include?(label_name) }
  end

  def repo_data(params)
    response = get_response(GITHUB_REPO_API_URL % params)
    return {} unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    { lang: data['language'].downcase, repository_name: data['name'] }
  end
end
