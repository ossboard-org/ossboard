require 'dry/monads/result'

module Web::Controllers::Tasks
  class Edit
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'tasks.operations.show']

    expose :task, :params

    def call(params)
      @params = params

      result = operation.call(id: params[:id])

      case result
      when Success
        @task = result.value!

        unless current_user.can_edit_task?(result.value!)
          flash[:error] = "You doesn't have access for editing this task"
          redirect_to routes.task_path(params[:id])
        end
      when Failure
        redirect_to(routes.tasks_path)
      end
    end
  end
end
