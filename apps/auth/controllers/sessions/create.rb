module Auth::Controllers::Sessions
  class Create
    include Auth::Action

    def call(params)
      if user_bloked?
        flash[:error] = 'Sorry, but you was blocked. Please contact with maintainer'
        redirect_to '/'
      end

      account = account_repo.find_by_uid(omniauth_params['uid']) || account_repo.create(account_params)

      unless account.user
        account_repo.update(account.id, user_id: user.id)
        account.user = user
      end

      set_session(account)
      redirect_to session[:current_path] || '/'
    end

    private

    def set_session(account)
      session[:account] = account
      session[:current_user] = account.user
    end

    def user
      @user ||= user_repo.find_by_login(user_params[:login]) || user_repo.create(user_params)
    end

    def user_bloked?
      BlokedUserRepository.new.exist?(user_params[:login])
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
      @user_params ||= {
        uuid: omniauth_params['uid'],
        login: omniauth_params['extra']['raw_info']['login'],
        avatar_url: omniauth_params['extra']['raw_info']['avatar_url'],
        name: omniauth_params['extra']['raw_info']['name'],
        email: omniauth_params['extra']['raw_info']['email'],
        bio: omniauth_params['extra']['raw_info']['bio']
      }
    end

    def account_params
      @account_params ||= {
        uid: omniauth_params['uid'],
        token: omniauth_params['credentials']['token']
      }
    end
  end
end
