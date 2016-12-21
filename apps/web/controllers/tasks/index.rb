module Web::Controllers::Tasks
  class Index
    include Web::Action
    expose :tasks

    def call(params)
      status = params[:status] || 'in progress'
      @tasks = TaskRepository.new.find_by_status(status)
    end
  end
end
