module Admin::Views::Tasks
  class Show
    include Admin::View

    def repository_name
      task.repository_name || '---'
    end

    def link_to_edit
      link_to 'Edit task', routes.edit_task_path(task.id), class: 'pure-button pure-button-primary'
    end

    def tasks_active?
      true
    end

    def link_to_issue
      if task.issue_url
        link_to task.issue_url, task.issue_url, target: '_blank'
      else
        'None'
      end
    end

    def link_to_assignee
      link_to task.assignee_username, "/users/#{task.assignee_username}"
    end

    def task_label
      if task.approved
        html.span(class: 'label label-success'){ 'Approved' }
      else
        html.span(class: 'label label-danger'){ 'Unapproved' }
      end
    end

    def task_complexity
      complexity_options_list.key(task.complexity)
    end

    def task_time_estimate
      time_estimate_options_list.key(task.time_estimate)
    end
  end
end
