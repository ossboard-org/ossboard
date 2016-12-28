class Task < Hanami::Entity
  VALID_STATUSES = {
    in_progress: 'in progress',
    assigned: 'assigned',
    closed: 'closed',
    done: 'done'
  }.freeze
end
