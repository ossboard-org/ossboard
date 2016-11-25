class TaskRepository < Hanami::Repository
  def only_approved
    tasks.where(approved: true).as(Task).to_a
  end

  def not_approved
    tasks.where(approved: false).as(Task).to_a
  end
end
