module Web::Controllers::Tasks
  class Index
    include Web::Action
    expose :tasks

    def call(params)
      @tasks = TaskRepository.new.only_approved
    end
  end
end
