class NewTaskNotificationWorker
  include Sidekiq::Worker
  include Import[
    task_repo: 'repositories.task',
    user_repo: 'repositories.user'
  ]

  def perform(task_id)
    task = task_repo.find(task_id)

    user_repo.admins.each do |admin|
      Mailers::NewTask.deliver(user: admin, task: task, format: :html)
    end
  end
end
