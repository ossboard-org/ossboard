class Mailers::NewTask
  include Hanami::Mailer

  from    'info@ossboard.com'
  to      :recipient
  subject 'OSSBoard: new task'

  def link_to_task
    "http://www.ossboard.org/admin/tasks/#{task.id}"
  end

private

  def recipient
    user.email
  end
end
