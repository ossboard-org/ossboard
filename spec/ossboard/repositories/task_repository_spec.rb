RSpec.describe TaskRepository do
  let(:repo) { TaskRepository.new }

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
