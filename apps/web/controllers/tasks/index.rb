module Web::Controllers::Tasks
  class Index
    include Web::Action
    expose :tasks

    def call(params)
      @tasks = TaskRepository.new.find_by_status(params[:status])
    end
  end
end
