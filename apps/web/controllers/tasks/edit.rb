require 'dry/monads/result'

module Web::Controllers::Tasks
  class Edit
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'tasks.operations.show']

    expose :task, :params

    def call(params)
      result = operation.call(id: params[:id])

      case result
      when Success
        @task = TaskRepository.new.find(params[:id])
        @author = UserRepository.new.find(@task.user_id) || User.new(name: 'Anonymous')

        unless current_user.can_edit_task?(@task)
          flash[:error] = "You doesn't have access for editing this task"
          redirect_to routes.task_path(params[:id])
        end

        @params = params
      when Failure
        redirect_to(routes.tasks_path)
      end
    end
  end
end
