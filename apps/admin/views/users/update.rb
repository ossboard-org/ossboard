module Admin::Views::Users
  class Update
    include Admin::View
    template 'users/edit'

    def users_active?
      true
    end
  end
end
