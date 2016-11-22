module Web::Views::Tasks
  class Index
    include Web::View

    def tasks
      TaskRepository.new.all
    end
  end
end
