require_relative '../../../../apps/api/controllers/analytics/index'

RSpec.describe Api::Controllers::Analytics::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(action.call(params)).to be_success }
  it { expect(action.call(params)).to match_in_body(/"labels":/) }
  it { expect(action.call(params)).to match_in_body(/"tasks":/) }
  it { expect(action.call(params)).to match_in_body(/"users":/) }
end
