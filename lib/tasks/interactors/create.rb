require 'hanami/interactor'

module Tasks
  module Interactors
    class Create
      include Hanami::Interactor

      expose :task

      def initialize(is_valid, **params)
        @params = params
        @is_valid = is_valid
      end

      def call
        if @is_valid
          @task = TaskRepository.new.create(task_params)
          NewTaskNotificationWorker.perform_async(@task.id)
        else
          @task = Task.new(@params[:task])
          error('invalid task attributes')
        end
      end

    private

      def task_params
        hash = @params[:task]
        hash[:body] = Container['core.markdown_parser'].call(hash[:md_body])
        hash[:status] = Task::VALID_STATUSES[:in_progress]
        hash[:approved] = nil
        hash
      end
    end
  end
end
