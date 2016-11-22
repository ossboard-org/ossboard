module Web::Views::Tasks
  class Index
    include Web::View

    def tasks
      TaskRepository.new.all
    end

    def link_to_task(task)
      link_to task.title, routes.task_path(id: task.id)
    end

    def link_to_new_task
      link_to 'new task', routes.new_task_path
    end
  end
end
