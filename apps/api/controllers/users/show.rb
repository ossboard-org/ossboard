module Api::Controllers::Users
  class Show
    include Api::Action
    include Hanami::Serializer::Action

    # TODO: move to operations
    def call(params)
      user = UserRepository.new.find_by_login_with_tasks(params[:id])

      hash = user ? serializer.new(user) : {}

      send_json(hash)
    end
  end
end
