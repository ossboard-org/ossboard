module Web::Views::Tasks
  class Show
    include Web::View

    def task_body
      raw(task.body)
    end

    def tasks_active?
      true
    end

    def link_to_author(user)
      link_to user.name, routes.user_path(id: user.id)
    end
  end
end
