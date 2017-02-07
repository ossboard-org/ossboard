module Web::Controllers::Users
  class Settings
    include Web::Action
    expose :user

    def call(params)
      @user = UserRepository.new.find_by_login(params[:id])
      redirect_to '/' unless @user

      # @repos = JSON.parse(HttpRequest.new("https://api.github.com/users/#{user.login}/repos?per_page=100").get.body)
    end
  end
end
