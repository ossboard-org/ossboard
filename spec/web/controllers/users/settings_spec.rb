require_relative '../../../../apps/web/controllers/users/settings'

RSpec.describe Web::Controllers::Users::Settings, type: :action do
  let(:action)  { described_class.new }
  let(:session) { { current_user: User.new } }
  let(:user)    { Fabricate.create(:user, name: 'Anton', login: 'davydovanton') }
  let(:params)  { { 'rack.session' => session, id: user.login } }

  context 'when user not register' do
    it { expect(action.call(params)).to redirect_to('/') }
  end

  context 'when user register and try to open other settings page' do
    let(:session) { { current_user: User.new(id: 1, login: 'testlogin') } }

    it { expect(action.call(params)).to redirect_to('/') }
  end

  context 'when user register and try to open self settings page' do
    let(:session) { { current_user: User.new(id: 1, login: 'davydovanton') } }

    it { expect(action.call(params)).to be_success }

    context 'when user not found' do
      let(:params)  { { id: 'empty' } }
      it { expect(action.call(params)).to redirect_to('/') }
    end

    describe 'expose' do
      context '#user' do
        it 'returns user by login' do
          action.call(params)
          expect(action.user).to be_a(User)
          expect(action.user.id).to eq user.id
        end
      end
    end
  end
end
