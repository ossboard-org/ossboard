class Mailers::TaskApproved
  include Hanami::Mailer

  from    'noreply@ossboard.org'
  to      :recipient
  subject 'OSSBoard: your task was approved!'

  def link_to_task
    "http://www.ossboard.org/tasks/#{task.id}"
  end

private

  def recipient
    user.email
  end
end
