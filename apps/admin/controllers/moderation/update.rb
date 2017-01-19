module Admin::Controllers::Moderation
  class Update
    include Admin::Action

    def call(params)
      if params[:action] == 'approve'
        TaskRepository.new.update(params[:id], { approved: true })
        ApproveTaskWorker.perform_async(params[:id])
      else
        TaskRepository.new.update(params[:id], { approved: false })
      end

      redirect_to routes.moderations_path
    end
  end
end
