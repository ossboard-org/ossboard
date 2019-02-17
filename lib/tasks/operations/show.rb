require 'dry/monads/result'
require 'dry/monads/do'

module Tasks
  module Operations
    class Show
      include Dry::Monads::Result::Mixin
      include Dry::Monads::Do.for(:call)

      include Import[task_repo: 'repositories.task']

      def call(id:)
        task = task_repo.find(id)
        task ? Success(task) : Failure(:not_found)
      end
    end
  end
end
