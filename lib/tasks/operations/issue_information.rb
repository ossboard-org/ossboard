require 'dry/monads/result'
require 'dry/monads/do'

module Tasks
  module Operations
    class IssueInformation
      include Dry::Monads::Result::Mixin
      include Dry::Monads::Do.for(:call)

      include Import[
        'tasks.matchers.git_host',
        'tasks.services.github_issue_requester',
        'tasks.services.gitlab_issue_requester'
      ]

      def call(is_valid, **params)
        is_valid ? match_host(params[:issue_url]) : Failure(EMPTY_URL_ERROR)
      end

    private

      EMPTY_URL_ERROR   = { error: 'empty url' }
      INVALID_URL_ERROR = { error: 'invalid url' }

      def match_host(issue_url)
        git_host.(issue_url) do |m|
          m.success(:github) { |issue_data| Success(github_issue_requester.(issue_data)) }
          m.success(:gitlab) { |issue_data| Success(gitlab_issue_requester.(issue_data)) }
          m.failure do
            Failure(INVALID_URL_ERROR)
          end
        end
      end
    end
  end
end
