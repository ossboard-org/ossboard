RSpec.describe User do
  describe '#registred?' do
    context 'when user is anonymous' do
      let(:user) { User.new }
      it { expect(user.registred?).to be false }
    end

    context 'when user is anonymous' do
      let(:user) { User.new(id: 1) }
      it { expect(user.registred?).to be true }
    end
  end
end
