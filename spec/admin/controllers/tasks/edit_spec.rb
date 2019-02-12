require_relative '../../../../apps/admin/controllers/tasks/edit'

RSpec.describe Admin::Controllers::Tasks::Edit, type: :action do
  let(:action) { described_class.new }
  let(:task) { Fabricate.create(:task, title: 'test') }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }
  let(:params)  { { id: task.id, 'rack.session' => session } }

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
