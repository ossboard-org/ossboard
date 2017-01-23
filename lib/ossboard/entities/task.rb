class Task < Hanami::Entity
  VALID_STATUSES = {
    in_progress: 'in progress',
    assigned: 'assigned',
    closed: 'closed',
    done: 'done'
  }.freeze

  # TODO: Tests
  def author
    UserRepository.new.find(user_id)
  end
end
