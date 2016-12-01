module Admin::Controllers::Moderation
  class Update
    include Admin::Action

    def call(params)
      TaskRepository.new.update(params[:id], { approved: true })
      redirect_to routes.moderations_path
    end
  end
end
