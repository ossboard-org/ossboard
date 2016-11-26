module Web::Views::Main
  class Index
    include Web::View

    def tasks
      TaskRepository.new.only_approved[0..2]
    end
  end
end
