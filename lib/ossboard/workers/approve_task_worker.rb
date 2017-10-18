class ApproveTaskWorker
  include Sidekiq::Worker
  include Import[
    user_repo: 'repositories.user',
    task_repo: 'repositories.task'
  ]

  include Import['services.task_twitter']

  def perform(task_id)
    task = task_repo.find(task_id)
    user = user_repo.find(task.user_id)

    return unless task

    Mailers::TaskApproved.deliver(user: user, task: task, format: :html)
    task_twitter.call(task)
  end
end
