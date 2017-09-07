module Web::Views::Leaderboards
  class Index
    include Web::View

    def users
      @users ||= UserRepository.new.all_with_points_and_tasks
    end

    # TODO: specs
    # TODO: replace to model
    def developers
      users.sort do |first, second|
        second.points.first&.developer <=> first.points.first&.developer
      end
    end

    def maintainers
      users.sort do |first, second|
        second.points.first&.maintainer <=> first.points.first&.maintainer
      end
    end

    def user_information(user)
      html.div(class: 'user-row__name') do
        a(href: routes.user_path(user.login)) do
          img class: 'user-row__avatar', src: user.avatar_url
          text(user.login)
        end
      end
    end
  end
end
