RSpec.describe TaskTwitter do
  let(:task) { Fabricate.create(:task, user_id: Fabricate.create(:user).id) }

  subject { TaskTwitter.new.call(task) }

  after do
    TaskRepository.new.clear
    UserRepository.new.clear
  end

  describe '#call' do
    context 'with correct text' do
      let(:task) { Fabricate.create(:task, user_id: Fabricate.create(:user).id) }

      it 'sends tweet' do
        expected_text = "#{task.title} #ossboard http://www.ossboard.org/tasks/#{task.id}"
        expect(subject).to eq expected_text
      end

      it 'shortens the url' do
        expect(UrlShortener).to receive(:call).with("http://www.ossboard.org/tasks/#{task.id}")
        subject
      end
    end

    context 'when title long' do
      let(:task) { Fabricate.create(:task, title: Faker::Lorem.paragraph, user_id: Fabricate.create(:user).id) }

      it { expect(subject.size).to be <= 140 }
    end
  end

  it "#twitter_client returs a twitter client" do
    expect(TWITTER_CLIENT).to be_a(Twitter::REST::Client)
  end
end
