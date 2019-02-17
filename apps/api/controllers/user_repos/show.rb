module Api::Controllers::UserRepos
  class Show
    include Api::Action
    include Import['core.http_request']

    params do
      required(:login).filled(:str?)
    end

    # TODO: move to operations
    def call(params)
      if params.valid?
        self.body = repos_page
      else
        self.status = 404
        self.body = '[]'
      end
    end

    private

    def repos_page(page = 1)
      http_request.get("https://api.github.com/users/#{params[:login]}/repos?per_page=100&page=#{page}").body
    end
  end
end
