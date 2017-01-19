module Web::Controllers::TaskStatus
  class Update
    include Web::Action

    def call(params)
      task = repo.find(params[:id])
      repo.update(task.id, task_params) if valid?(task)
      redirect_to routes.task_path(task.id)
    end

  private

    ALLOWED_STATUSES = [Task::VALID_STATUSES[:assigned], Task::VALID_STATUSES[:closed], Task::VALID_STATUSES[:done]].freeze

    def repo
      @repo ||= TaskRepository.new
    end

    def valid?(task)
      task && current_user.author?(task) &&
        ALLOWED_STATUSES.include?(params[:status]) &&
        (task.status == Task::VALID_STATUSES[:in_progress] ||
         task.status == Task::VALID_STATUSES[:assigned])
    end

    def task_params
      if params[:status] == Task::VALID_STATUSES[:assigned]
        { status: params[:status], assignee_username: params[:assignee_username] }
      else
        { status: params[:status] }
      end
    end

    def verify_csrf_token?
      false
    end
  end
end
