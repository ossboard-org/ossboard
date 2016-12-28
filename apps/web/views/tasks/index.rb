module Web::Views::Tasks
  class Index
    include Web::View

    def title
      'OSSBoard: tasks'
    end

    def link_to_task(task)
      link_to task.title, routes.task_path(id: task.id)
    end

    def link_to_new_task
      link_to 'Submit new task', routes.new_task_path, class: 'btn btn-new-task'
    end

    def status_selected_class(status)
      'pure-menu-selected' if tasks_status == status
    end

    def task_statuses
      {
        'in progress' => 'In progress',
        'assigned' => 'Assigned',
        'closed' => 'Closed',
        'done' => 'Finished'
      }
    end

    def tasks_status
      params[:status] || 'in progress'
    end

    def tasks_active?
      true
    end
  end
end
