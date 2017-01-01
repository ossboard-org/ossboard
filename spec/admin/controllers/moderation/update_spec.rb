require_relative '../../../../apps/admin/controllers/moderation/update'

RSpec.describe Admin::Controllers::Moderation::Update do
  let(:action)  { described_class.new }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }
  let(:params)  { { id: task.id, 'rack.session' => session } }

  let(:repo) { TaskRepository.new }
  let(:task) { Fabricate.create(:task, approved: false, user_id: Fabricate.create(:user).id) }

  after { repo.clear }

  it { expect { action.call(params) }.to change { repo.find(task.id).approved } }
  it { expect(action.call(params)).to redirect_to('/admin/moderation')  }
  it { expect{ action.call(params) }.to change { Hanami::Mailer.deliveries.size }.by(1) }
end
