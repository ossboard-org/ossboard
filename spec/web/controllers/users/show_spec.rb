require_relative '../../../../apps/web/controllers/users/show'

RSpec.describe Web::Controllers::Users::Show do
  let(:action) { described_class.new }
  let(:user) { Fabricate.create(:user, name: 'Anton', login: 'davydovanton') }
  let(:params)  { { id: user.login } }

  before do
    TaskRepository.new.clear
    UserRepository.new.clear
  end

  after do
    TaskRepository.new.clear
    UserRepository.new.clear
  end

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
        expect(action.user.tasks).to_not be nil
      end
    end
  end
end
