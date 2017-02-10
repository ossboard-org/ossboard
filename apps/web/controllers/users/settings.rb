module Web::Controllers::Users
  class Settings
    include Web::Action
    expose :user

    def call(params)
      @user = UserRepository.new.find_by_login(params[:id])
      redirect_to '/' if @user.nil? || current_user.login != @user.login
    end
  end
end
