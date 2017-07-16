module Api::Controllers::Analytics
  class Index
    include Api::Action
    include Import['services.analytic_reporter']

    def call(params)
      self.body = JSON.generate(analytic_reporter.call)
    end
  end
end
