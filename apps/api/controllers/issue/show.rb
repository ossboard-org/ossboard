module Api::Controllers::Issue
  class Show
    include Api::Action
    include Hanami::Serializer::Action
    include Import['tasks.interactors.issue_information']

    params do
      required(:issue_url).filled(:str?)
    end

    def call(params)
      result = issue_information.new(params.valid?, params).call

      status = result.failure? ? 404 : 200

      send_json(result.response, status: status)
    end
  end
end
