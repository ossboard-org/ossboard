module Admin::Views::Tasks
  class Show
    include Admin::View

    def link_to_edit(task)
      link_to 'Edit task', routes.edit_task_path(task.id), class: 'pure-button pure-button-primary'
    end

    def tasks_active?
      true
    end
  end
end
