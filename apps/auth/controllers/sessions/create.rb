module Auth::Controllers::Sessions
  class Create
    include Auth::Action

    def call(params)
      if user_bloked?(omniauth_params)
        flash[:error] = 'Sorry, but you was blocked. Please contact with maintainer'
        redirect_to '/'
      end

      account = account_repo.find_by_uid(omniauth_params['uid']) || account_repo.create(account_params)

      unless account.user
        account_repo.update(account.id, user_id: finded_user_by_login.id)
        account = account_repo.find(account.id)
      end

      set_session(account)
      redirect_to session[:current_path] || '/'
    end

    private

    def set_session(account)
      session[:account] = account
      session[:current_user] = account.user
    end

    def finded_user_by_login
      @finded_user_by_login ||= user_repo.find_by_login(user_params[:login]) || user_repo.create(user_params)
    end

    def user_bloked?(omniauth_params)
      BlokedUserRepository.new.exist?(omniauth_params['extra']['raw_info']['login'])
    end

    def user_repo
      @user_repo ||= UserRepository.new
    end

    def account_repo
      @account_repo ||= AccountRepository.new
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

    def account_params
      params = {}
      params[:uid]   = omniauth_params['uid']
      params[:token] = omniauth_params['credentials']['token']
      params
    end
  end
end
