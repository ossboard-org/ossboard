module Admin::Views::Users
  class Show
    include Admin::View

    def users_active?
      true
    end

    def link_to_edit
      link_to 'Edit user', routes.edit_user_path(user.id), class: 'pure-button pure-button-primary'
    end
  end
end
