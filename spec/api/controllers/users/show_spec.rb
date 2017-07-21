require_relative '../../../../apps/api/controllers/users/show'

RSpec.describe Api::Controllers::Users::Show do
  let(:action) { described_class.new }
  let(:params) { Hash[id: user.login] }
  let(:user) { Fabricate.create(:user, name: 'Anton', login: 'davydovanton') }

  subject { action.call(params) }

  after { UserRepository.new.clear }

  context 'when params invalid' do
    let(:params) { Hash[] }
    it { expect(subject).to be_success }
    it { expect(subject).to match_in_body '{}' }
  end

  context 'when user not exist params invalid' do
    let(:params) { Hash[id: 'notexist'] }
    it { expect(subject).to be_success }
    it { expect(subject).to match_in_body '{}' }
  end

  context 'when params valid' do
    it { expect(subject).to be_success }
    it { expect(subject).to match_in_body '"name":"Anton","login\":"davydovanton"' }
    it { expect(subject).to match_in_body '"tasks":\[\]' }
  end
end
