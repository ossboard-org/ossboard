require 'dry/monads/result'
require 'dry/monads/do'

module Tasks
  module Operations
    class UpdateStatus
      include Dry::Monads::Result::Mixin
      include Dry::Monads::Do.for(:call)

      include Import[
        'core.markdown_parser',
        task_repo: 'repositories.task'
      ]

      def call(current_user, payload)
        task = task_repo.find(payload[:id])
        task_repo.update(task.id, task_params(payload)) if valid?(task, current_user, payload[:status])
      end

    private

      ALLOWED_STATUSES = [Task::VALID_STATUSES[:assigned], Task::VALID_STATUSES[:closed], Task::VALID_STATUSES[:done]].freeze

      def valid?(task, current_user, status)
        task && task.opened? && current_user.author?(task) && ALLOWED_STATUSES.include?(status)
      end

      def task_params(payload)
        if payload[:status] == Task::VALID_STATUSES[:assigned]
          { status: payload[:status], assignee_username: assignee_username(payload) }
        else
          { status: payload[:status] }
        end
      end

      def assignee_username(payload)
        payload[:assignee_username].gsub(/[^\w\s]/, '')
      end
    end
  end
end
