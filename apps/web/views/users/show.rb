module Web::Views::Users
  class Show
    include Web::View

    def title
      "OSSBoard: #{user.login}"
    end

    def link_to_task(task)
      if task.approved
        link_to task.title, routes.task_path(id: task.id)
      else
        html.span { task.title }
      end
    end

    def link_to_settings
      return unless current_user == user

      link_to 'Settings', routes.settings_user_path(current_user.login)
    end

    def task_status_style(task)
      'waiting-task' unless task.approved
    end

    def complited_tasks
      TaskRepository.new.assigned_tasks_for_user(user)
    end
  end
end
