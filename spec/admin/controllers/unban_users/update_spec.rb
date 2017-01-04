require_relative '../../../../apps/admin/controllers/unban_users/update'

RSpec.describe Admin::Controllers::UnbanUsers::Update do
  let(:action) { described_class.new }
  let(:username) { 'davydovanton' }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }
  let(:params)  { { username: username, 'rack.session' => session } }

  before { BlokedUserRepository.new.create('anton') }
  after { REDIS.with(&:flushdb) }

  context 'when username was banned' do
    let(:username) { 'anton' }

    it 'unbans user' do
      action.call(params)
      expect(BlokedUserRepository.new.exist?(username)).to eq false
    end

    it { expect(action.call(params)).to redirect_to('/admin/users')  }
  end

  context 'when username was not banned' do
    let(:username) { 'davydovanton' }

    it 'doing nothing' do
      action.call(params)
      expect(BlokedUserRepository.new.exist?(username)).to eq false
    end

    it { expect(action.call(params)).to redirect_to('/admin/users')  }
  end
end
