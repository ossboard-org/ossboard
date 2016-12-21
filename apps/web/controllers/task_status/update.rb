module Web::Controllers::TaskStatus
  class Update
    include Web::Action

    def call(params)
      task = repo.find(params[:id])
      repo.update(task.id, status: params[:status]) if valid?(task)
      redirect_to routes.task_path(task.id)
    end

  private

    ALLOWED_STATUSES = [Task::VALID_STATUSES[:closed], Task::VALID_STATUSES[:done]].freeze

    def repo
      @repo ||= TaskRepository.new
    end

    def valid?(task)
      task && task.author?(current_user) &&
        ALLOWED_STATUSES.include?(params[:status]) &&
        task.status == Task::VALID_STATUSES[:in_progress]
    end
  end
end
