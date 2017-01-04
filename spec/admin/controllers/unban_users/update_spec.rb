require_relative '../../../../apps/admin/controllers/unban_users/update'

RSpec.describe Admin::Controllers::UnbanUsers::Update do
  let(:action) { described_class.new }
  let(:login) { 'davydovanton' }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }
  let(:params)  { { login: login, 'rack.session' => session } }

  before { BlokedUserRepository.new.create('anton') }
  after { REDIS.with(&:flushdb) }

  context 'when login was banned' do
    let(:login) { 'anton' }

    it 'unbans user' do
      action.call(params)
      expect(BlokedUserRepository.new.exist?(login)).to eq false
    end

    it { expect(action.call(params)).to redirect_to('/admin/users')  }
  end

  context 'when login was not banned' do
    let(:login) { 'davydovanton' }

    it 'doing nothing' do
      action.call(params)
      expect(BlokedUserRepository.new.exist?(login)).to eq false
    end

    it { expect(action.call(params)).to redirect_to('/admin/users')  }
  end
end
