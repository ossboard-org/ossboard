module Api::Controllers::Issue
  class Show
    include Api::Action

    params do
      required(:issue_url).filled(:str?)
    end

    def call(params)
      result = Interactors::Issues::Show.new(params.valid?, params).call
      self.status = 404 if result.failure?
      self.body = JSON.generate(result.response)
    end
  end
end
