module Auth::Controllers::Sessions
  class Create
    include Auth::Action

    def call(params)
      require 'pp'
      pp params.env['omniauth.auth']
    end
  end
end
