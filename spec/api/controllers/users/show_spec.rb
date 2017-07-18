require_relative '../../../../apps/api/controllers/users/show'

RSpec.describe Api::Controllers::Users::Show do
  let(:action) { described_class.new }
  let(:params) { Hash[id: 'davydovanton'] }

  subject { action.call(params) }

  context 'when params invalid' do
    let(:params) { Hash[] }
    it { expect(subject).to be_success }
  end

  context 'when params valid' do
    it { expect(subject).to be_success }
  end
end
