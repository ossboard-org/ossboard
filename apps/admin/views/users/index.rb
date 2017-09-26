module Admin::Views::Users
  class Index
    include Admin::View

    def users
      UserRepository.new.users.order{ id.desc }.map_to(User).to_a
    end

    def banned_users
      @banned_users ||= BlokedUserRepository.new.all
    end

    def link_to_user(user)
      link_to user.name || user.login, routes.user_path(user.id)
    end

    def users_active?
      true
    end

    def user_role(user)
      user.admin ? 'admin' : 'user'
    end

    def link_to_block(user)
      if banned_users.include?(user.login)
        html.form(action: "/admin/unban_users/#{user.id}", method: "POST") do
          input(type: "hidden", name: "_method",  value: "PATCH")
          input(type: "hidden", name: "login",    value: user.login)
          input(class: 'pure-button pure-button-green', type: "submit", value: "Unblock")
        end

      else

        html.form(action: "/admin/users/#{user.id}", method: "POST") do
          input(type: "hidden", name: "_method",  value: "DELETE")
          input(type: "hidden", name: "login",    value: user.login)
          input(class: 'pure-button pure-button-danger', type: "submit", value: "Block")
        end
      end
    end
  end
end
