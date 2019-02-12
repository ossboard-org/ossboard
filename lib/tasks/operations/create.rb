require 'dry/monads/result'
require 'dry/monads/do'

module Tasks
  module Operations
    class Create
      include Dry::Monads::Result::Mixin
      include Dry::Monads::Do.for(:call)

      include Import[
        'core.markdown_parser',
        task_repo: 'repositories.task'
      ]

      def call(is_valid, **params)
        return Failure('invalid task attributes') unless is_valid

        task = task_repo.create(task_params(params))
        NewTaskNotificationWorker.perform_async(task.id)

        Success(task)
      end

    private

      def task_params(params)
        hash = params[:task]
        hash[:body] = markdown_parser.call(hash[:md_body])
        hash[:status] = Task::VALID_STATUSES[:in_progress]
        hash[:approved] = nil
        hash
      end
    end
  end
end
