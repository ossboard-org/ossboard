require 'dry/monads/result'
require 'dry/monads/do'

module Api::Controllers::Issue
  class Show
    include Api::Action
    include Hanami::Serializer::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'tasks.operations.issue_information']

    params do
      required(:issue_url).filled(:str?)
    end

    def call(params)
      result = operation.call(params.valid?, params)

      case result
      when Success
        send_json(result.value!, status: 200)
      when Failure
        send_json(result.failure, status: 404)
      end
    end
  end
end
