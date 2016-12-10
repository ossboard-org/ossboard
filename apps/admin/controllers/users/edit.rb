module Admin::Controllers::Users
  class Edit
    include Admin::Action
    expose :user

    def call(params)
      @user = UserRepository.new.find(params[:id])
    end
  end
end
