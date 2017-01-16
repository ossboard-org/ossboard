module Web::Controllers::Tasks
  class New
    include Web::Action

    expose :task, :params, :updated_csrf_token

    def call(params)
      @params = params
      @task = Task.new
    end
  end
end
