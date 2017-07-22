module Web::Controllers::TaskStatus
  class Update
    include Web::Action

    def call(params)
      Interactors::TaskStatus::Update.new(current_user, params).call
      redirect_to routes.task_path(params[:id])
    end

  private

    def verify_csrf_token?
      false
    end
  end
end
