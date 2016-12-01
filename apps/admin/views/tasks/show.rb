module Admin::Views::Tasks
  class Show
    include Admin::View

    def link_to_edit
      link_to 'Edit task', routes.edit_task_path(task.id), class: 'pure-button pure-button-primary'
    end

    def tasks_active?
      true
    end

    def task_label
      if task.approved
        html.span(class: 'label label-success'){ 'Approved' }
      else
        html.span(class: 'label label-danger'){ 'Unapproved' }
      end
    end
  end
end
