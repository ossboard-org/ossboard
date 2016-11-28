module Web::Views::Main
  class Index
    include Web::View

    def tasks
      TaskRepository.new.only_approved.take(3)
    end
  end
end
