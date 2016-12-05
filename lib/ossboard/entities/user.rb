class User < Hanami::Entity
  def registred?
    !!id
  end
end
