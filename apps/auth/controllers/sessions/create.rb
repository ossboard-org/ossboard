module Auth::Controllers::Sessions
  class Create
    include Auth::Action

    def call(params)
      if user_bloked?(omniauth_params)
        flash[:error] = 'Sorry, but you was blocked. Please contact with maintainer'
        redirect_to '/'
      end

      session[:current_user] = repo.find_by_uuid(omniauth_params['uid']) || repo.create(user_params)
      redirect_to session[:current_path] || '/'
    end

    private

    def user_bloked?(omniauth_params)
      BlokedUserRepository.new.exist?(omniauth_params['extra']['raw_info']['login'])
    end

    def repo
      @repo ||= UserRepository.new
    end

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
