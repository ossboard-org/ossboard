module Api::Controllers::Issue
  class Show
    include Api::Action
    include Import['tasks.interactors.issue_information']

    params do
      required(:issue_url).filled(:str?)
    end

    def call(params)
      result = issue_information.new(params.valid?, params).call
      self.status = 404 if result.failure?
      self.body = JSON.generate(result.response)
    end
  end
end
