module Admin::Controllers::Moderation
  class Update
    include Admin::Action

    def call(params)
      TaskRepository.new.update(params[:id], { approved: true })
      ApproveTaskWorker.perform_async(params[:id])
      redirect_to routes.moderations_path
    end
  end
end
