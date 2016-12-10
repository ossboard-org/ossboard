module Web::Views::Tasks
  class Show
    include Web::View

    def task_body
      raw(task.body)
    end

    def tasks_active?
      true
    end
  end
end
