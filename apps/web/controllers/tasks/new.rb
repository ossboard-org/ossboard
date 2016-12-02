module Web::Controllers::Tasks
  class New
    include Web::Action

    expose :task, :params

    def call(params)
      @params = params
      @task = Task.new
    end
  end
end
