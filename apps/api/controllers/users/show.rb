module Api::Controllers::Users
  class Show
    include Api::Action

    def call(params)
      user = UserRepository.new.find_by_login_with_tasks(params[:id])
      self.body = user_to_hash(user).to_json
    end

  private

    def user_to_hash(user)
      user ? { **user.to_h, tasks: user.tasks.map(&:to_h) } : {}
    end
  end
end
