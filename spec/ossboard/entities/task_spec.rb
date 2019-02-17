RSpec.describe Task do

  let(:user) { Fabricate.create(:user, login: 'testtest') }

  describe "#author" do
    context 'when no author is assigned to task' do
      let(:task) { Task.new(id: 2) }
      it { expect(task.author).to eq(nil) }
    end

    context 'when author is present' do
      let(:task) { Fabricate.create(:task, user_id: user.id) }

      it { expect(task.author.login).to eq(user.login) }
    end
  end

  describe '#opened?' do
    [
     ['in progress', true],
     ['assigned', true],
     ['closed', false],
     ['done', false],
     ['moderation', false]
    ].each do |status, result|
      it { expect(Task.new(status: status).opened?).to eq result }
    end
  end
end
