RSpec.describe Task do
  let(:task) { Task.new(user_id: 1) }
  let(:user) { User.new(id: 1) }

  describe '#author?' do
    context 'when user is author of task' do
      it { expect(task.author?(user)).to be true }
    end

    context 'when user is not author of task' do
      let(:user) { User.new(id: 2) }
      it { expect(task.author?(user)).to be false }
    end
  end
end
