module Api::Controllers::Users
  class Show
    include Api::Action

    def call(params)
      user = UserRepository.new.find_by_login_with_tasks(params[:id])
      self.body = user.to_h.to_json
    end
  end
end
