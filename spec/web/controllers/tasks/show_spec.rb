require_relative '../../../../apps/web/controllers/tasks/show'

RSpec.describe Web::Controllers::Tasks::Show, type: :action do
  let(:action) { described_class.new }
  let(:task) { Fabricate.create(:task, title: 'test') }
  let(:params) { { id: task.id } }

  it { expect(action.call(params)).to be_success }

  describe 'expose' do
    context '#task' do
      it 'returns task by id' do
        action.call(params)
        expect(action.task).to eq task
      end
    end

    context '#author' do
      let(:author) { Fabricate.create(:user, name: 'test') }
      let(:task) { Fabricate.create(:task, title: 'test', user_id: author.id) }

      it 'returns author of task' do
        action.call(params)
        expect(action.author).to eq author
      end

      context 'when author is empty (unreal case)' do
        let(:task) { Fabricate.create(:task, title: 'test') }

        it 'returns author of task' do
          action.call(params)
          expect(action.author.name).to eq 'Anonymous'
        end
      end
    end
  end
end
