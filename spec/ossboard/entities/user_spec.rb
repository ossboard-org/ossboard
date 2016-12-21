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

  describe '#author?' do
    let(:task) { Task.new(user_id: 1) }
    let(:user) { User.new(id: 1) }

    context 'when user is author of task' do
      it { expect(user.author?(task)).to be true }
    end

    context 'when user is not author of task' do
      let(:user) { User.new(id: 2) }
      it { expect(user.author?(task)).to be false }
    end
  end
end
