module Admin::Views::Moderation
  class Index
    include Admin::View

    def link_to_task(task)
      link_to task.title, routes.task_path(task.id)
    end

    def tasks
      TaskRepository.new.not_approved
    end

    def approve_task_button(task)
      form_for :task, routes.moderation_path(task.id), { method: :patch } do
        submit 'Approve', class: 'pure-button moderation-table__approve'
      end
    end

    def params
      {}
    end

    def moderation_active?
      true
    end
  end
end
