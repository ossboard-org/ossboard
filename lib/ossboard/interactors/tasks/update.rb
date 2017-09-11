require 'hanami/interactor'

module Interactors
  module Tasks
    class Update
      include Hanami::Interactor
      include Import['core.markdown']

      expose :task

      def initialize(params_valid, params)
        @params = params
        @params_valid = params_valid
        @task = repo.find(@params[:id])
      end

      def call
        return error('No task found') unless @task
        return error('Unprocessable entity') unless @params_valid

        prepare_task_params
        repo.update(@task.id, @params[:task])
      end

    private

      def repo
        TaskRepository.new()
      end

      def prepare_task_params
        @params[:task][:body] = Core::Markdown.new().parse(@params[:task][:md_body])
      end
    end
  end
end
