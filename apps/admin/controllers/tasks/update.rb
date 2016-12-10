module Admin::Controllers::Tasks
  class Update
    include Admin::Action
    expose :task

    params do
      required(:id).filled
      required(:task).schema do
        required(:title).filled(:str?)
        required(:md_body).filled(:str?)
        required(:approved).filled
        required(:lang).filled
      end
    end

    def call(params)
      repo = TaskRepository.new
      @task = repo.find(params[:id])

      if @task && params.valid?
        task_params = params[:task]
        task_params[:body] = MARKDOWN.render(task_params[:md_body])

        @task = repo.update(@task.id, task_params)

        redirect_to routes.task_path(task.id)
      else
        self.status = 422
      end
    end
  end
end
