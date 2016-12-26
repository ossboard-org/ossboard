module Admin::Views::Users
  class Index
    include Admin::View

    def users
      UserRepository.new.all
    end

    def link_to_user(user)
      link_to user.name, routes.user_path(user.id)
    end

    def users_active?
      true
    end

    def user_role(user)
      user.admin ? 'admin' : 'user'
    end

    def link_to_block(user)
      html.form(action: "/admin/users/#{user.id}", method: "POST") do
        input(type: "hidden", name: "_method",  value: "DELETE")
        input(type: "hidden", name: "login",    value: user.login)
        input(class: 'pure-button pure-button-danger', type: "submit", value: "Block")
      end
    end
  end
end
