module Web::Views::Task
  class Create
    include Web::View
    template 'tasks/new'

    def tasks_active?
      true
    end
  end
end
