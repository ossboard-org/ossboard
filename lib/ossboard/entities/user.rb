class User < Hanami::Entity
  def registred?
    !!id
  end

  def author?(task)
    id == task.user_id
  end
end
