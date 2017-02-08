module Api::Controllers::UserRepos
  class Show
    include Api::Action

    params do
      required(:login).filled(:str?)
    end

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
      HttpRequest.new("https://api.github.com/users/#{params[:login]}/repos?per_page=100&page=#{page}").get.body
    end
  end
end
