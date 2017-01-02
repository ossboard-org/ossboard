class NewTaskNotificationWorker
  include Sidekiq::Worker

  def perform(task_id)
    task = TaskRepository.new.find(task_id)

    UserRepository.new.admins.each do |admin|
      Mailers::NewTask.deliver(user: admin, task: task, format: :html)
    end
  end
end
