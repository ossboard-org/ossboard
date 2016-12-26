module Web::Controllers::Tasks
  class Edit
    include Web::Action

    expose :task, :params

    def call(params)
      @params = params
      @task = TaskRepository.new.find(params[:id])
    end
  end
end
