module Admin::Controllers::Users
  class Update
    include Admin::Action
    expose :user

    params do
      required(:id).filled
      required(:user).schema do
        required(:name).filled(:str?)
        required(:login).filled(:str?)
        required(:email).filled(:str?)
        required(:bio).filled(:str?)
        required(:admin).filled
      end
    end

    def call(params)
      # TODO: To operation
      @user = repo.find(params[:id])

      if @user && params.valid?
        user_params = params[:user]
        user_params[:admin] = user_params[:admin] == '1'

        repo.update(@user.id, user_params)
        redirect_to routes.user_path(user.id)
      else
        self.status = 422
      end
    end

  private

    def repo
      @repo ||= UserRepository.new
    end
  end
end
