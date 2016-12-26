module Admin::Controllers::Users
  class Destroy
    include Admin::Action

    def call(params)
      BlokedUserRepository.new.create(params[:login])
      redirect_to '/admin/users'
    end

  private

    def verify_csrf_token?
      false
    end
  end
end
