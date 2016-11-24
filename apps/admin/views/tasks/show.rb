module Admin::Views::Tasks
  class Show
    include Admin::View

    def link_to_edit(task)
      link_to 'Edit task', routes.edit_task_path(task.id)
    end
  end
end
