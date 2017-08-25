require_relative '../../../../apps/admin/controllers/users/destroy'

RSpec.describe Admin::Controllers::Users::Destroy do
  let(:action) { described_class.new }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }
  let(:params)  { { id: 1, 'rack.session' => session, login: 'davydovanton' } }

  before do
    OSSBoard::Application[:redis].with(&:flushdb)

    Fabricate.create(:user, login: 'davydovanton')
  end

  it { expect(action.call(params)).to redirect_to '/admin/users' }

  it 'blocks user' do
    expect{ action.call(params) }.to change { BlokedUserRepository.new.all.count }.by(1)
    expect(BlokedUserRepository.new.exist?('davydovanton')).to eq true
  end

  context 'when user is admin' do
    before { Fabricate.create(:user, login: 'admindavydovanton', admin: true) }
    let(:params)  { { id: 1, 'rack.session' => session, login: 'admindavydovanton' } }

    it 'does not block user' do
      expect{ action.call(params) }.to change { BlokedUserRepository.new.all.count }.by(0)
      expect(BlokedUserRepository.new.exist?('admindavydovanton')).to eq false
    end
  end
end
