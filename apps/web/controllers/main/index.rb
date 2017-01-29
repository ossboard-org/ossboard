module Web::Controllers::Main
  class Index
    include Web::Action
    expose :tasks

    def call(params)
      @tasks = TaskRepository.new.only_approved.first(3)
    end
  end
end
