module Admin::Views::Tasks
  class Index
    include Admin::View

    def tasks
      TaskRepository.new.all
    end

    def link_to_task(task)
      link_to task.title, routes.task_path(id: task.id)
    end

    def tasks_active?
      true
    end

    def task_label(task)
      if task.approved
        html.span(class: 'label label-success'){ 'Approved' }
      else
        html.span(class: 'label label-danger'){ 'Unapproved' }
      end
    end

    def status_label(task)
      html.span(class: "label #{STATUS_LABELS[task.status]}"){ task.status }
    end

  private

    STATUS_LABELS = {
      'in progress' => 'label-info',
      'closed' => 'label-danger',
      'done' => 'label-success'
    }.freeze
  end
end
