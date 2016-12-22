RSpec.describe TaskRepository do
  let(:repo) { TaskRepository.new }

  describe '#find_by_status' do
    before do
      repo.create(title: 'in progress', approved: true, status: 'in progress')
      repo.create(title: 'closed', approved: true, status: 'closed')
      repo.create(title: 'done', approved: true, status: 'done')
    end

    after { repo.clear }

    context 'when key empty' do
      it 'returns array of closed tasks' do
        expect(repo.find_by_status(nil)).to all(be_a(Task))
        expect(repo.find_by_status(nil).count).to eq 3
      end
    end

    context 'when key is closed' do
      it 'returns array of closed tasks' do
        expect(repo.find_by_status('closed')).to all(be_a(Task))
        expect(repo.find_by_status('closed').count).to eq 1
        expect(repo.find_by_status('closed').first.status).to eq 'closed'
      end
    end

    context 'when key is done' do
      it 'returns array of done tasks' do
        expect(repo.find_by_status('done')).to all(be_a(Task))
        expect(repo.find_by_status('done').count).to eq 1
        expect(repo.find_by_status('done').first.status).to eq 'done'
      end
    end

    context 'when key is in progress' do
      it 'returns array of in progress tasks' do
        expect(repo.find_by_status('in progress')).to all(be_a(Task))
        expect(repo.find_by_status('in progress').count).to eq 1
        expect(repo.find_by_status('in progress').first.status).to eq 'in progress'
      end
    end

    context 'when key is invalid' do
      it 'returns array of all tasks' do
        expect(repo.find_by_status('test')).to all(be_a(Task))
        expect(repo.find_by_status('test').count).to eq 3
      end
    end
  end

  describe '#only_approved' do
    before do
      repo.create(title: 'bad')
      repo.create(title: 'good', approved: true)
    end

    after { repo.clear }

    it 'returns array of tasks' do
      expect(repo.only_approved).to all(be_a(Task))
    end

    it 'returns only approved tasks' do
      expect(repo.only_approved.size).to eq 1
      expect(repo.only_approved.last.title).to eq 'good'
    end
  end

  describe '#om_moderation_for_user' do
    before do
      repo.create(title: 'good', approved: false, user_id: user.id)
      repo.create(title: 'good', approved: false)
    end

    let(:user) { UserRepository.new.create(name: 'anton') }

    after { repo.clear }

    it 'returns array of tasks' do
      expect(repo.om_moderation_for_user(user.id)).to all(be_a(Task))
      expect(repo.om_moderation_for_user(user.id).count).to eq 1
      expect(repo.om_moderation_for_user(user.id).last.user_id).to eq user.id
    end
  end

  describe '#not_approved' do
    before do
      repo.create(title: 'bad')
      repo.create(title: 'good', approved: true)
    end

    after { repo.clear }

    it 'returns array of tasks' do
      expect(repo.not_approved).to all(be_a(Task))
    end

    it 'returns not approved tasks' do
      expect(repo.not_approved.size).to eq 1
      expect(repo.not_approved.last.title).to eq 'bad'
    end
  end
end
