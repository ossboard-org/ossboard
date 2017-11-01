RSpec.describe Account do
  describe '#registred?' do
    context 'when user is anonymous' do
      let(:account) { Account.new }
      it { expect(account.registred?).to be false }
    end

    context 'when user is anonymous' do
      let(:account) { Account.new(id: 1) }
      it { expect(account.registred?).to be true }
    end
  end

  describe '#attributes' do
    let(:account) { Account.new(id: 1, token: 'test') }
    it { expect(account.attributes).to eq(id: 1, token: 'test') }
  end
end
