class Account < Hanami::Entity
  def registred?
    !!id
  end

  # TODO: Tests
  def user=(user)
    attributes[:user] = user
  end

  def user
    attributes[:user] || UserRepository.new.find(user_id)
  end

private

  attr_reader :attributes
end
