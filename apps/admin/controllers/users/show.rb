module Admin::Controllers::Users
  class Show
    include Admin::Action
    expose :user

    def call(params)
      @user = UserRepository.new.find_with_tasks(params[:id])
    end
  end
end
