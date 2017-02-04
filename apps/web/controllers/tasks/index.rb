module Web::Controllers::Tasks
  class Index
    include Web::Action
    expose :tasks

    def call(params)
      @tasks = if params[:status] == 'moderation' && authenticated?
        TaskRepository.new.on_moderation_for_user(current_user.id)
      else
        TaskRepository.new.find_by(status: status, lang: lang)
      end
    end

  private

    ALLOWED_STATUSES = Task::VALID_STATUSES.values
    ALLOWED_LANGUAGES = Task::VALID_LANGUAGES.values

    def status
      ALLOWED_STATUSES.include?(params[:status]) ? params[:status] : 'in progress'
    end

    def lang
      ALLOWED_LANGUAGES.include?(params[:lang]) ? params[:lang] : 'any'
    end
  end
end
