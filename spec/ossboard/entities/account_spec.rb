RSpec.describe Account do
  describe '#registred?' do
    context 'when user is anonymous' do
      let(:user) { Account.new }
      it { expect(user.registred?).to be false }
    end

    context 'when user is anonymous' do
      let(:user) { Account.new(id: 1) }
      it { expect(user.registred?).to be true }
    end
  end
end
