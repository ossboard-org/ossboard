class ApproveTaskWorker
  include Sidekiq::Worker
  include Import['services.task_twitter']

  def perform(task_id)
    task = TaskRepository.new.find(task_id)
    user = UserRepository.new.find(task.user_id)

    return unless task

    Mailers::TaskApproved.deliver(user: user, task: task, format: :html)
    task_twitter.call(task)
  end
end
