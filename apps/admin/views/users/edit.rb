module Admin::Views::Users
  class Edit
    include Admin::View

    def users_active?
      true
    end

    def form
      form_for user_form, id: 'user-form', class: 'user-form pure-form pure-form-stacked' do
        div class: 'user-form__fields' do
          div class: 'input user-form__field pure-control-group' do
            label      :name
            text_field :name, value: user.name
          end

          div class: 'input user-form__field pure-control-group' do
            label      :login
            text_field :login, value: user.login
          end

          div class: 'input user-form__field pure-control-group' do
            label      :email
            text_field :email, value: user.email
          end

          div class: 'input user-form__field pure-control-group' do
            label     :bio
            text_area :bio, user.bio
          end

          div class: 'input user-form__field pure-control-group' do
            label     :admin
            check_box :admin, checked: checkbox_status
          end
        end

        div class: 'user-form__actions pure-controls' do
          a 'back', href: routes.user_path(user.id), class: 'pure-button'
          submit 'Update', class: 'pure-button pure-button-primary'
        end
      end
    end

    def user_form
      Form.new(:user, routes.user_path(user.id),
        { user: user }, { method: :patch })
    end

    def params
      {}
    end

    def checkbox_status
      user.admin ? 'checked' : nil
    end
  end
end
