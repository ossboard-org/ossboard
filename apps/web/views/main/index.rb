module Web::Views::Main
  class Index
    include Web::View

    def tasks
      TaskRepository.new.only_approved.take(3)
    end

    def link_to_tasks
      link_to 'View All Tasks', routes.tasks_path, class: 'pure-button'
    end

    def link_to_new_tasks
      link_to 'Submit Task', routes.new_task_path, class: 'pure-button'
    end

    def link_to_task(task)
      link_to 'Open task', routes.task_path(id: task.id), class: 'pure-button'
    end
  end
end
