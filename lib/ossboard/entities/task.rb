class Task < Hanami::Entity
  VALID_STATUSES = {
    in_progress: 'in progress',
    closed: 'closed',
    done: 'done'
  }.freeze

  def author?(user)
    user_id == user.id
  end
end
