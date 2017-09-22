require "dry-matcher"

module Tasks
  module Matchers
    module GitHost
      ISSUE_REGEXP = %r[\.com/([\w-]+)/([\w.-]+)/issues/(\d+)].freeze

      SUCCESS_CASE = Dry::Matcher::Case.new(
        match:   -> value, pattern do
          value.match(pattern.to_s) && value.match(ISSUE_REGEXP)
        end,
        resolve: -> value do
          match = value.match(ISSUE_REGEXP)
          { org: match[1], repo: match[2], issue: match[3] }
        end
      )

      FAILURE_CASE = Dry::Matcher::Case.new(
        match: -> value { true },
        resolve: -> _ {}
      )

      Matcher = Dry::Matcher.new(success: SUCCESS_CASE, failure: FAILURE_CASE)
    end
  end
end
