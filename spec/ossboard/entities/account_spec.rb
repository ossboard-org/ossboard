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

  describe '#user=' do
    let(:account) { Account.new }
    let(:user) { User.new }

    it 'sets user' do
      account.user = user
      expect(account.attributes).to eq(user: user)
    end
  end

  describe '#user' do
    let(:account) { Account.new(id: 1, token: 'test') }

    it { expect(account.user).to eq nil }

    context 'when users was set' do
      let(:user) { User.new(login: 'davydovanton') }

      it 'returns user entity' do
        account.user = user
        expect(account.user).to eq user
      end
    end

    context 'wen user exist in DB' do
      let(:user) { UserRepository.new.create(login: 'davydovanton') }

      it 'returns user entity' do
        account.user = user
        expect(account.user).to eq user
      end
    end
  end
end
