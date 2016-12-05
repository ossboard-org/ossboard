module Auth::Controllers::Sessions
  class Destroy
    include Auth::Action

    def call(params)
      session[:current_user] = nil
      redirect_to '/'
    end
  end
end
