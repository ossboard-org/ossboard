class Account < Hanami::Entity
  def registred?
    !!id
  end

  # TODO: Tests
  def user
    UserRepository.new.find(user_id)
  end
end
