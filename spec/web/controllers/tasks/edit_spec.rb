require_relative '../../../../apps/web/controllers/tasks/edit'

RSpec.describe Web::Controllers::Tasks::Edit do
  let(:action) { described_class.new }
  let(:params) { { id: task.id } }
  let(:task)   { TaskRepository.new.create(title: 'TestTask') }
  let(:repo)   { TaskRepository.new }

  after { repo.clear }

  it { expect(action.call(params)).to be_success }

  describe 'expose' do
    context '#task' do
      it 'returns task by id' do
        action.call(params)
        expect(action.task).to eq task
      end
    end

    context '#params' do
      it 'returns action params' do
        action.call(params)
        expect(action.params).to be_a Hanami::Action::BaseParams
      end
    end
  end
end
