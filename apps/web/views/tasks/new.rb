module Web::Views::Tasks
  class New
    include Web::View

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

        submit 'Create'
      end
    end

    def task_form
      Form.new(:task, routes.tasks_path, {}, { method: :post })
    end

    def tasks_active?
      true
    end
  end
end
