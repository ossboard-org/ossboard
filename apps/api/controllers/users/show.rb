module Api::Controllers::Users
  class Show
    include Api::Action

    def call(params)
      self.body = 'OK'
    end
  end
end
