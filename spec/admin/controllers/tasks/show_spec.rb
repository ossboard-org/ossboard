require 'spec_helper'
require_relative '../../../../apps/admin/controllers/tasks/show'

RSpec.describe Admin::Controllers::Tasks::Show do
  let(:action) { described_class.new }
  let(:task) { TaskRepository.new.create(title: 'test') }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }
  let(:params)  { { id: task.id, 'rack.session' => session } }

  after { TaskRepository.new.clear }

  it { expect(action.call(params)).to be_success }

  describe 'expose' do
    context '#task' do
      it 'returns task by id' do
        action.call(params)
        expect(action.task).to eq task
      end
    end
  end
end
