module Web::Controllers::Tasks
  class Edit
    include Web::Action
    expose :task, :params

    def call(params)
      @task = TaskRepository.new.find(params[:id])

      unless allow_to_edit_task?
        flash[:error] = "You doesn't have access for editing this task"
        redirect_to routes.task_path(params[:id])
      end

      @params = params
    end

  private

    def allow_to_edit_task?
      authenticated? && current_user.author?(@task) && !@task.approved
    end
  end
end
