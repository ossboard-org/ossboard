module Web::Views::Tasks
  class New
    include Web::View

    def form
      form_for :task, routes.task_path do
        text_field :title
        text_area :body

        submit 'Create'
      end
    end
  end
end
