module Web::Views::Tasks
  class Index
    include Web::View

    def tasks
      TaskRepository.new.only_approved
    end

    def link_to_task(task)
      link_to task.title, routes.task_path(id: task.id)
    end

    def link_to_new_task
      link_to 'Submit new task', routes.new_task_path, class: 'pure-button'
    end
  end
end
