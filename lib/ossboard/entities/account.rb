class Account < Hanami::Entity
  # TODO: Tests
  def user
    UserRepository.new.find(user_id)
  end
end
