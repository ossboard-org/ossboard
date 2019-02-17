require 'dry/monads/result'
require 'dry/monads/do'

module Tasks
  module Operations
    class Update
      include Dry::Monads::Result::Mixin
      include Dry::Monads::Do.for(:call)

      include Import[
        'core.markdown_parser',
        task_repo: 'repositories.task'
      ]

      def call(params_valid, params)
        return Failure('Unprocessable entity') unless params_valid
        return Failure('No task found') unless task_repo.find(params[:id])

        if params[:task][:md_body]
          params[:task][:body] = markdown_parser.call(params[:task][:md_body])
        end

        Success(task_repo.update(params[:id], params[:task]))
      end
    end
  end
end
