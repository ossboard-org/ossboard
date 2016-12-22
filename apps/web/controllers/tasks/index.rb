module Web::Controllers::Tasks
  class Index
    include Web::Action
    expose :tasks

    def call(params)
      @tasks = if params[:status] == 'moderation' && authenticated?
        TaskRepository.new.om_moderation_for_user(current_user.id)
      else
        TaskRepository.new.find_by_status(params[:status] || 'in progress')
      end
    end
  end
end
