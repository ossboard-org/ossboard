module Admin::Controllers::Tasks
  class Update
    include Admin::Action
    expose :task

    params do
      required(:id).filled
      required(:task).schema do
        required(:title).filled(:str?)
        required(:body).filled(:str?)
        required(:approved).filled
      end
    end

    def call(params)
      repo = TaskRepository.new
      @task = repo.find(params[:id])

      if @task && params.valid?
        @task = repo.update(@task.id, params[:task])
        redirect_to routes.task_path(task.id)
      else
        self.status = 422
      end
    end
  end
end
