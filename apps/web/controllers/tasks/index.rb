module Web::Controllers::Tasks
  class Index
    include Web::Action
    expose :tasks

    def call(params)
      search_params = {}
      search_params[:status] = status if status
      search_params[:lang] = lang if lang

      @tasks = for_moderation? ?
        repo.on_moderation_for_user(current_user.id) :
        repo.find_by(search_params)
    end

  private

    ALLOWED_STATUSES = Task::VALID_STATUSES.values
    ALLOWED_LANGUAGES = Task::VALID_LANGUAGES.values

    def for_moderation?
      params[:status] == 'moderation' && authenticated?
    end

    def repo
      @repo ||= TaskRepository.new
    end

    def status
      ALLOWED_STATUSES.include?(params[:status]) ? params[:status] : 'in progress'
    end

    def lang
      ALLOWED_LANGUAGES.include?(params[:lang]) && params[:lang]
    end
  end
end
