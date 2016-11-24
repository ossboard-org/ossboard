require 'spec_helper'
require_relative '../../../../apps/admin/controllers/tasks/edit'

RSpec.describe Admin::Controllers::Tasks::Edit do
  let(:action) { described_class.new }
  let(:task) { TaskRepository.new.create(title: 'test') }
  let(:params) { { id: task.id } }

  after { TaskRepository.new.clear }

  it 'is successful' do
    response = action.call(params)
    expect(response).to be_success
  end

  describe 'expose' do
    context '#task' do
      it 'returns task by id' do
        action.call(params)
        expect(action.task).to eq task
      end
    end
  end
end
