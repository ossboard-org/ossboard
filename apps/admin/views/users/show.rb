module Admin::Views::Users
  class Show
    include Admin::View

    def users_active?
      true
    end

    def link_to_edit
      link_to 'Edit user', routes.edit_user_path(user.id), class: 'pure-button pure-button-primary'
    end

    def link_to_task(task)
      link_to task.title, routes.task_path(id: task.id)
    end

    def task_label(task)
      if task.approved
        html.span(class: 'label label-success'){ 'Approved' }
      else
        html.span(class: 'label label-danger'){ 'Unapproved' }
      end
    end
  end
end
