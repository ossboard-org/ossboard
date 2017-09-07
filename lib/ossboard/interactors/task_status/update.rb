module Interactors
  module TaskStatus
    class Update
      def initialize(current_user, params)
        @current_user = current_user
        @params = params
      end

      def call
        @task = repo.find(@params[:id])
        repo.update(@task.id, task_params) if valid?
      end

    private

      ALLOWED_STATUSES = [Task::VALID_STATUSES[:assigned], Task::VALID_STATUSES[:closed], Task::VALID_STATUSES[:done]].freeze

      def repo
        @repo ||= TaskRepository.new
      end

      def valid?
        @task && @current_user.author?(@task) &&
          ALLOWED_STATUSES.include?(@params[:status]) &&
          (@task.status == Task::VALID_STATUSES[:in_progress] ||
           @task.status == Task::VALID_STATUSES[:assigned])
      end

      def task_params
        if @params[:status] == Task::VALID_STATUSES[:assigned]
          { status: @params[:status], assignee_username: assignee_username }
        else
          { status: @params[:status] }
        end
      end

      def assignee_username
        @params[:assignee_username].gsub(/[^\w\s]/, '')
      end

    end
  end
end
