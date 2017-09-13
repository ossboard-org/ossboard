module Admin::Controllers::Tasks
  class Update
    include Admin::Action
    include Import['core.markdown']
    expose :task

    params do
      required(:id).filled
      required(:task).schema do
        required(:title).filled(:str?)
        required(:md_body).filled(:str?)
        required(:approved).filled
        required(:lang).filled
        required(:status).filled
        required(:complexity).filled
        required(:time_estimate).filled
        optional(:issue_url).maybe(:str?)
        optional(:repository_name).maybe(:str?)
        optional(:assignee_username).maybe(:str?)
      end
    end

    def call(params)
      result = Interactors::Tasks::Update.new(params.valid?, params).call
      @task = result.task

      if result.successful?
        redirect_to routes.task_path(result.task.id)
      else
        self.status = 422
        redirect_to routes.edit_task_path(result.task.id)
      end
    end
  end
end
