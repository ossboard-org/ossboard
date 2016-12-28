module Web::Controllers::Users
  class Show
    include Web::Action
    expose :user

    def call(params)
      @user = UserRepository.new.find_with_tasks(params[:id])

      redirect_to '/' unless @user
    end
  end
end
