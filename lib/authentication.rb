module Authentication
  def self.included(action)
    action.class_eval do
      # before :authenticate!
      expose :current_user
    end
  end

private

  # def authenticate!
  #   halt 401 unless authenticated?
  # end

  def authenticated?
    !!current_user
  end

  def current_user
    @current_user ||= session[:current_user] || User.new
  end
end
