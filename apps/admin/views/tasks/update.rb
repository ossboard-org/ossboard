module Admin::Views::Tasks
  class Update
    include Admin::View
    template 'tasks/edit'

    def tasks_active?
      true
    end
  end
end
