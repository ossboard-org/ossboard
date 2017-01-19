require_relative '../../../../apps/admin/controllers/moderation/update'

RSpec.describe Admin::Controllers::Moderation::Update do
  let(:action)  { described_class.new }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }
  let(:params)  { { id: task.id, action: action_value, 'rack.session' => session } }

  let(:repo) { TaskRepository.new }
  let(:task) { Fabricate.create(:task, approved: nil, user_id: Fabricate.create(:user).id) }

  after { repo.clear }

  context 'when action is approve' do
    let(:action_value) { 'approve' }

    it { expect { action.call(params) }.to change { repo.find(task.id).approved }.to(true) }
    it { expect(action.call(params)).to redirect_to('/admin/moderation')  }
    it { expect{ action.call(params) }.to change { ApproveTaskWorker.jobs.size }.by(1) }
  end

  context 'when action is deny' do
    let(:action_value) { 'deny' }

    it { expect { action.call(params) }.to change { repo.find(task.id).approved }.to(false) }
    it { expect(action.call(params)).to redirect_to('/admin/moderation')  }
    it { expect{ action.call(params) }.to change { ApproveTaskWorker.jobs.size }.by(0) }
  end
end
