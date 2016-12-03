module Web::Controllers::Main
  class Index
    include Web::Action

    def call(params)
      p current_user
    end
  end
end
