require 'dry/monads/result'

module Web::Controllers::Tasks
  class Show
    include Web::Action
    include Dry::Monads::Result::Mixin
    include Import[operation: 'tasks.operations.show']

    expose :task, :author

    # TODO: move author logic to tasks domain
    def call(params)
      result = operation.call(id: params[:id])

      case result
      when Success
        @task = result.value!
        @author = UserRepository.new.find(@task.user_id) || User.new(name: 'Anonymous')
      when Failure
        redirect_to(routes.tasks_path)
      end
    end
  end
end
