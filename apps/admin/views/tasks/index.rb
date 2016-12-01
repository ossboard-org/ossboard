module Admin::Views::Tasks
  class Index
    include Admin::View

    def tasks
      TaskRepository.new.all
    end

    def link_to_task(task)
      link_to task.title, routes.task_path(id: task.id)
    end

    def tasks_active?
      true
    end
  end
end
