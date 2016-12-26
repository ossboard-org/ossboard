module Web::Controllers::Tasks
  class Edit
    include Web::Action
    expose :task, :params

    def call(params)
      @task = TaskRepository.new.find(params[:id])

      unless current_user.can_edit_task?(task)
        flash[:error] = "You doesn't have access for editing this task"
        redirect_to routes.task_path(params[:id])
      end

      @params = params
    end
  end
end
