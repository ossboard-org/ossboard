module Web::Controllers::Leaderboards
  class Index
    include Web::Action
    expose :users, :developers, :maintainers

    # TODO: replace to model
    def call(params)
      @users = UserRepository.new.all_with_points_and_tasks

      @developers = @users.sort do |first, second|
        second.points.first&.developer <=> first.points.first&.developer
      end

      @maintainers = @users.sort do |first, second|
        second.points.first&.maintainer <=> first.points.first&.maintainer
      end
    end
  end
end
