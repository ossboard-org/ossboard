module Admin::Controllers::UnbanUsers
  class Update
    include Admin::Action

    def call(params)
      BlokedUserRepository.new.delete(params[:login])
      redirect_to routes.users_path
    end
  end
end
