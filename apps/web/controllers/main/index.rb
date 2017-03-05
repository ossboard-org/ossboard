require 'hanami/action/cache'

module Web::Controllers::Main
  class Index
    include Web::Action
    include Hanami::Action::Cache
    expose :tasks

    def call(params)
      fail
      @tasks = TaskRepository.new.only_approved.first(3)
      fresh last_modified: @tasks.first&.created_at
    end
  end
end
