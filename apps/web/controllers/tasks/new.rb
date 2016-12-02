module Web::Controllers::Tasks
  class New
    include Web::Action

    expose :task

    def call(params)
      @task = Task.new
    end
  end
end
