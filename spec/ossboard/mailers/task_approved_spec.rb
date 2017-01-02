require 'spec_helper'

describe Mailers::TaskApproved do
  before { Hanami::Mailer.deliveries.clear }
  let(:user) { User.new(email: 'anton@ossboard.org') }
  let(:task) { Task.new(id: 1) }

  it 'delivers email' do
    Mailers::TaskApproved.deliver(user: user, task: task)
    mail = Hanami::Mailer.deliveries.last

    expect(mail.to).to eq [user.email]
    expect(mail.subject).to eq 'OSSBoard: your task was approved!'
    expect(mail.body.encoded).to match "http://www.ossboard.org/tasks/#{task.id}"
  end
end
