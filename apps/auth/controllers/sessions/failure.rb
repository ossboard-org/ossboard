module Auth::Controllers::Sessions
  class Failure
    include Auth::Action

    def call(params)
      redirect_to '/'
    end
  end
end
