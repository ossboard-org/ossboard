module Web::Controllers::Tasks
  class Create
    include Web::Action

    expose :task

    params do
      required(:task).schema do
        required(:title).filled(:str?)
        required(:body).filled(:str?)
      end
    end

    def call(params)
      if params.valid?
        @task = TaskRepository.new.create(params[:task])
        redirect_to routes.root_path
      else
        self.status = 422
      end
    end
  end
end
