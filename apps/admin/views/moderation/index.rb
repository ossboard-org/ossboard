module Admin::Views::Moderation
  class Index
    include Admin::View

    def tasks
      TaskRepository.new.not_approved
    end
  end
end
