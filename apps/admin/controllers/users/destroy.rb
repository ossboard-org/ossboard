module Admin::Controllers::Users
  class Destroy
    include Admin::Action

    def call(params)
      BlokedUserRepository.new.create(params[:login]) unless admin_user?
      redirect_to '/admin/users'
    end

  private

    def admin_user?
      UserRepository.new.find_by_login(params[:login]).admin
    end

    def verify_csrf_token?
      false
    end
  end
end
