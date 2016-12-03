module Auth::Controllers::Sessions
  class Create
    include Auth::Action

    def call(params)
      repo = UserRepository.new
      session[:current_user] = repo.find_by_uuid(omniauth_params['uid']) || repo.create(user_params)
      redirect_to '/'
    end

    private

    def omniauth_params
      @omniauth_params ||= params.env['omniauth.auth']
    end

    def user_params
      params = {}
      params[:uuid] = omniauth_params['uid']
      params[:login] = omniauth_params['extra']['raw_info']['login']
      params[:avatar_url] = omniauth_params['extra']['raw_info']['avatar_url']
      params[:name] = omniauth_params['extra']['raw_info']['name']
      params[:email] = omniauth_params['extra']['raw_info']['email']
      params[:bio] = omniauth_params['extra']['raw_info']['bio']
      params
    end
  end
end
