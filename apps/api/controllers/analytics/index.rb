module Api::Controllers::Analytics
  class Index
    include Api::Action

    def call(params)
      response = { hello: :world }
      self.body = JSON.generate(response)
    end
  end
end
