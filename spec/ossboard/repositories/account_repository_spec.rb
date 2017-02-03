RSpec.describe AccountRepository do

  describe '#find_by_uid' do
    let(:repo) { AccountRepository.new }

    context 'when user exist with uuid' do
      before { repo.create(uid: 'test') }
      after  { repo.clear }

      it { expect(repo.find_by_uid('test')).to be_a Account }
      it { expect(repo.find_by_uid('test').uid).to eq 'test' }
    end

    context 'when user not exist with uuid' do
      it { expect(repo.find_by_uid('test2')).to eq nil }
    end
  end
end
