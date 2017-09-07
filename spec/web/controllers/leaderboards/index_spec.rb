require_relative '../../../../apps/web/controllers/leaderboards/index'

RSpec.describe Web::Controllers::Leaderboards::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(action.call(params)).to be_success }

  describe 'exposes' do
    describe '#users' do
      before do
        UserRepository.new.create(login: 'anton')
        action.call(params)
      end

      it 'returns all users' do
        expect(action.users).to every(be_an(User))
      end
    end
  end
end
