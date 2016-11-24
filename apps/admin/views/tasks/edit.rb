module Admin::Views::Tasks
  class Edit
    include Admin::View

    def form
      form_for task_form, id: 'task-form' do
        div class: 'input' do
          label      :title
          text_field :title, value: task.title
        end

        div class: 'input' do
          label      :body
          text_field :body, value: task.body
        end

        submit 'Update'
        a 'back', href: routes.task_path(task.id)
      end
    end

    def task_form
      Form.new(:task, routes.task_path(task.id),
        { task: task }, { method: :patch })
    end

    def params
      {}
    end
  end
end
