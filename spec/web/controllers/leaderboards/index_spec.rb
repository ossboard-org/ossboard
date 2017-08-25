require_relative '../../../../apps/web/controllers/leaderboards/index'

RSpec.describe Web::Controllers::Leaderboards::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(action.call(params)).to be_success }
end
