module Web::Controllers::Tasks
  class Show
    include Web::Action
    expose :task

    def call(params)
      @task = TaskRepository.new.find(params[:id])
    end
  end
end
