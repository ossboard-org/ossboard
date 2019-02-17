module Web::Controllers::TaskStatus
  class Update
    include Web::Action
    include Import['tasks.interactors.update_status']

    # TODO: move to operations
    def call(params)
      update_status.new(current_user, params).call
      redirect_to routes.task_path(params[:id])
    end

  private

    def verify_csrf_token?
      false
    end
  end
end
