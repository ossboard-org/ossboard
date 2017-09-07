module Web::Controllers::Leaderboards
  class Index
    include Web::Action
    expose :users

    def call(params)
      @users ||= UserRepository.new.all_with_points_and_tasks
    end
  end
end
