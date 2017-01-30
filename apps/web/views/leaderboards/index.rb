module Web::Views::Leaderboards
  class Index
    include Web::View

    def users
      UserRepository.new.all.last(5)
    end
  end
end
