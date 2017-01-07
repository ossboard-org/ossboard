module Api::Controllers::Analytics
  class Index
    include Api::Action

    def call(params)
      self.body = JSON.generate(AnalyticReporter.new.call)
    end

  private

    ONE_MONTH = 30
  end
end
