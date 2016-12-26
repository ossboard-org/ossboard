class User < Hanami::Entity
  def registred?
    !!id
  end

  def author?(task)
    id == task.user_id
  end

  def can_edit_task?(task)
    registred? && author?(task) && !task.approved
  end
end
