module Web::Views::Tasks
  class New
    include Web::View

    def form
      form_for task_form, id: 'task-form' do
        text_field :title
        text_area :body

        submit 'Create'
      end
    end

    def task_form
      Form.new(:task, routes.tasks_path, {}, { method: :post })
    end

    def params
      {}
    end
  end
end
