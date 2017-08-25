RSpec.describe ApproveTaskWorker do
  let(:task) { Fabricate.create(:task, user_id: Fabricate.create(:user).id) }
  subject { ApproveTaskWorker.new }

  describe '#perform' do
    it 'sends email to all admins' do
      VCR.use_cassette("approve_task_worker") do
        expect{ subject.perform(task.id) }.to change { Hanami::Mailer.deliveries.size }.by(1)
      end
    end
  end
end
