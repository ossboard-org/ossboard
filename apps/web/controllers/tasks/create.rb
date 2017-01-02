module Web::Controllers::Tasks
  class Create
    include Web::Action

    expose :task

    params do
      required(:task).schema do
        required(:title).filled(:str?)
        required(:md_body).filled(:str?)
        required(:lang).filled(:str?)
        required(:user_id).filled
        optional(:issue_url).maybe(:str?)
        optional(:repository_name).maybe(:str?)
      end
    end

    def call(params)
      if params.valid? && authenticated?
        task_params = params[:task]
        task_params[:body] = Markdown.parse(task_params[:md_body])
        task_params[:status] = Task::VALID_STATUSES[:in_progress]

        task = TaskRepository.new.create(task_params)

        NewTaskNotificationWorker.perform_async(task.id)
        flash[:info] = 'Task had been added to moderation. You can check your task status on profile page'

        redirect_to routes.tasks_path
      else
        @task = Task.new(params[:task])
        self.body = Web::Views::Tasks::New.render(format: format, task: @task, current_user: current_user, params: params)
      end
    end
  end
end
