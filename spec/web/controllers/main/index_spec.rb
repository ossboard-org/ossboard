require_relative '../../../../apps/web/controllers/main/index'

RSpec.describe Web::Controllers::Main::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(action.call(params)).to be_success }
end
