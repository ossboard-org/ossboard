class Account < Hanami::Entity
  attr_reader :attributes

  def registred?
    !!id
  end

  def user
    attributes[:user] || UserRepository.new.find(user_id)
  end
end
