require 'hanami/interactor'

module Interactors
  module Issues
    class Show
      include Hanami::Interactor

      expose :response

      def initialize(is_valid, **params)
        @params = params
        @is_valid = is_valid
      end

      def call
        @response = if @is_valid
          match_host(@params[:issue_url])
        else
          error('invalid params') && EMPTY_URL_ERROR
        end
      end

    private

      EMPTY_URL_ERROR   = { error: 'empty url' }
      INVALID_URL_ERROR = { error: 'invalid url' }

      def match_host(issue_url)
        Matchers::GitHost::Matcher.(issue_url) do |m|
          m.success(:github) { |issue_data| Services::GithubIssueRequester.(issue_data) }
          m.success(:gitlab) { |issue_data| Services::GitlabIssueRequester.(issue_data) }
          m.failure { error('invalid url') && INVALID_URL_ERROR }
        end
      end
    end
  end
end
