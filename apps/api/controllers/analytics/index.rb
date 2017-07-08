module Api::Controllers::Analytics
  class Index
    include Api::Action

    def call(params)
      self.body = JSON.generate(Services::AnalyticReporter.new.call)
    end
  end
end
