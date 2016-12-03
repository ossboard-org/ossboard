RSpec.describe UserRepository do
  let(:repo) { UserRepository.new }

  after { repo.clear }

  describe '#find_by_uuid' do
    context 'when user exist with uuid' do
      before { repo.create(uuid: 'test') }
      it { expect(repo.find_by_uuid('test')).to be_a User }
      it { expect(repo.find_by_uuid('test').uuid).to eq 'test' }
    end

    context 'when user not exist with uuid' do
      it { expect(repo.find_by_uuid('test2')).to eq nil }
    end
  end
end
