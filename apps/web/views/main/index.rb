module Web::Views::Main
  class Index
    include Web::View

    def tasks
      TaskRepository.new.only_approved.take(3)
    end

    def link_to_tasks
      link_to 'View All Tasks', routes.tasks_path, class: 'pure-button'
    end
  end
end
