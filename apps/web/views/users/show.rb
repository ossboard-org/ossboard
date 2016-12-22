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

    def task_status_style(task)
      'waiting-task' unless task.approved
    end
  end
end
