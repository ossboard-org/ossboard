module Authentication
  def self.included(action)
    action.class_eval do
      expose :current_user
    end
  end

private

  def authenticate_admin!
    redirect_to('/') unless authenticated? && current_user.admin
  end

  def authenticated?
    current_user.registred?
  end

  def current_user
    @current_user ||= session[:current_user] || User.new
  end
end
