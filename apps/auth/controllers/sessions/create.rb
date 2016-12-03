module Auth::Controllers::Sessions
  class Create
    include Auth::Action

    def call(params)
      repo = UserRepository.new

      params.env['omniauth.auth']
      session[:current_user] = repo.find_by_uuid(params.env['omniauth.auth']['uuid']) || User.new
      redirect_to '/'
    end
  end
end
