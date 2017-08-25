require 'spec_helper'

describe Mailers::NewTask do
  let(:user) { User.new(email: 'anton@ossboard.org') }
  let(:task) { Task.new(id: 1) }

  it 'delivers email' do
    Mailers::NewTask.deliver(user: user, task: task)
    mail = Hanami::Mailer.deliveries.last

    expect(mail.to).to eq [user.email]
    expect(mail.subject).to eq 'OSSBoard: new task'
    expect(mail.body.encoded).to match "http://www.ossboard.org/admin/tasks/#{task.id}"
  end
end
