module Web::Controllers::Tasks
  class Index
    include Web::Action
    expose :tasks

    def call(params)
      @tasks = repo.find_by(search_params)
    end

  private

    def search_params
      for_moderation? ?
        lang_params(user_id: current_user.id, approved: nil) :
        lang_params(status: status, approved: true)
    end


    def for_moderation?
      params[:status] == 'moderation' && authenticated?
    end

    def lang_params(search_params)
      search_params[:lang] = params[:lang] if Task::VALID_LANGUAGES.values.include?(params[:lang])
      search_params
    end

    def repo
      @repo ||= TaskRepository.new
    end

    def status
      Task::VALID_STATUSES.values.include?(params[:status]) ? params[:status] : 'in progress'
    end
  end
end
