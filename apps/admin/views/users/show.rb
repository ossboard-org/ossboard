module Admin::Views::Users
  class Show
    include Admin::View

    def users_active?
      true
    end
  end
end
