require_relative '../../../../apps/admin/controllers/users/destroy'

RSpec.describe Admin::Controllers::Users::Destroy do
  let(:action) { described_class.new }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }
  let(:params)  { { id: 1, 'rack.session' => session, login: 'davydovanton' } }

  before { Fabricate.create(:user, login: 'davydovanton') }
  after { REDIS.with(&:flushdb) }

  it { expect(action.call(params)).to redirect_to '/admin/users' }

  it 'blocks user' do
    expect{ action.call(params) }.to change { BlokedUserRepository.new.all.count }.by(1)
    expect(BlokedUserRepository.new.exist?('davydovanton')).to eq true
  end
end
