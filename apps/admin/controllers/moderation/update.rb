module Admin::Controllers::Moderation
  class Update
    include Admin::Action

    def call(params)
      TaskRepository.new.update(params[:id], { approved: true })
      send_email_to_author
      redirect_to routes.moderations_path
    end

  private

    # todo: sidekiq here
    def send_email_to_author
      task = TaskRepository.new.find(params[:id])
      user = UserRepository.new.find(task.user_id)

      Mailers::TaskApproved.deliver(user: user, task: task, format: :html)
    end
  end
end
