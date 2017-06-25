module Api::Controllers::Issue
  class Show
    include Api::Action

    params do
      required(:issue_url).filled(:str?)
    end

    def call(params)
      generate_response
      self.status = 404 if @response[:error]
      self.body = JSON.generate(@response)
    end

  private

    EMPTY_URL_ERROR   = { error: 'empty url' }
    INVALID_URL_ERROR = { error: 'invalid url' }

    def generate_response
      @response ||= params.valid? ? match_host(params[:issue_url]) : EMPTY_URL_ERROR
    end

    def match_host(issue_url)
      GitHostMatcher.(issue_url) do |m|
        m.success(:github) { |issue_data| GithubIssueRequester.(issue_data) }
        m.success(:gitlab) { |issue_data| GitlabIssueRequester.(issue_data) }
        m.failure { INVALID_URL_ERROR }
      end
    end
  end
end
