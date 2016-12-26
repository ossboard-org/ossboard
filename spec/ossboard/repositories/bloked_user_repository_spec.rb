RSpec.describe BlokedUserRepository do
  before { REDIS.with(&:flushdb) }

  let(:repo) { BlokedUserRepository.new }

  describe '#all' do
    context 'when blocked users not exist' do
      it 'returns empty array' do
        expect(repo.all).to eq []
      end
    end

    context 'when blocked users exist' do
      before {
        repo.create('anton1')
        repo.create('anton2')
        repo.create('anton3')
      }

      it 'returns array of nicknames' do
        expect(repo.all).to eq %w[anton3 anton2 anton1]
      end
    end
  end

  describe '#create' do
    it 'creates bloked user value' do
      repo.create('anton')
      expect(repo.all).to include 'anton'
    end

    context 'when user alredy exist' do
      before { repo.create('anton') }

      it 'does nothing' do
        expect{ repo.create('anton') }.to change { repo.all.count }.by(0)
      end
    end
  end

  describe '#exist?' do
    context 'when blocked user exist' do
      before { repo.create('anton') }
      it { expect(repo.exist?('anton')).to eq true }
    end

    context 'when blocked user exist' do
      it { expect(repo.exist?('anton')).to eq false }
    end
  end
end
