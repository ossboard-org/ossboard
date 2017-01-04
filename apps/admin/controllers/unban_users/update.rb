module Admin::Controllers::UnbanUsers
  class Update
    include Admin::Action

    def call(params)
      BlokedUserRepository.new.delete(params[:login])
      redirect_to routes.users_path
    end

  private

    def verify_csrf_token?
      false
    end
  end
end
