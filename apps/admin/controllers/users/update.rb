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
      result = Interactors::Users::Update.new(params.valid?, params).call
      @user = result.user

      if result.successful?
        redirect_to routes.user_path(user.id)
      else
        self.status = 422
      end
    end
  end
end
