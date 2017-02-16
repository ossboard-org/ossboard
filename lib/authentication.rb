module Authentication
  def self.included(action)
    action.class_eval do
      expose :current_user
      expose :account
    end
  end

private

  def authenticate_admin!
    redirect_to('/') unless authenticated? && current_user.admin
  end

  def authenticated?
    current_user.registred? || account.registred?
  end

  def current_user
    @current_user ||= User.new(session[:current_user])
  end

  def account
    @account ||= Account.new(session[:account])
  end
end
