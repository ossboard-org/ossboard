module Web::Views::Tasks
  class New
    include Web::View

    def form
      form_for task_form, id: 'task-form', class: 'pure-form' do
        div class: 'input' do
          text_field :title, value: task.title, placeholder: 'Title'
        end

        div class: 'input' do
          text_area :body, value: task.body, placeholder: 'Body'
        end

        div class: 'input' do
          select :lang, { 'language' => 'undefined', 'ruby' => 'ruby', 'js' => 'js' }
        end

        a 'Back', href: routes.tasks_path, class: 'btn btn-back'

        if current_user.id
          submit('Create', class: 'pure-button pure-button-primary')
        else
          span('Create', class: 'pure-button pure-button-disabled')
        end
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
