RSpec.describe NewTaskNotificationWorker do
  let(:task) { Fabricate.create(:task) }
  subject { NewTaskNotificationWorker.new }

  after do
    TaskRepository.new.clear
    UserRepository.new.clear
  end

  describe '#perform' do
    before { 3.times { Fabricate.create(:user, admin: true) } }

    it 'sends email to all admins' do
      expect{ subject.perform(task.id) }.to change { Hanami::Mailer.deliveries.size }.by(3)
    end
  end
end
