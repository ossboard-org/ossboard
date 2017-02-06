module Web::Controllers::Tasks
  class Index
    include Web::Action
    expose :tasks

    def call(params)
      @tasks = for_moderation? ? repo.on_moderation_for_user(current_user.id) : repo.find_by(search_params)
    end

  private

    def for_moderation?
      params[:status] == 'moderation' && authenticated?
    end

    def search_params
      @search_params = { status: status }
      @search_params[:lang] = params[:lang] if Task::VALID_LANGUAGES.values.include?(params[:lang])
      @search_params
    end

    def repo
      @repo ||= TaskRepository.new
    end

    def status
      Task::VALID_STATUSES.values.include?(params[:status]) ? params[:status] : 'in progress'
    end
  end
end
