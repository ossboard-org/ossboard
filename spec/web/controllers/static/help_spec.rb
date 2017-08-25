require_relative '../../../../apps/web/controllers/static/help'

RSpec.describe Web::Controllers::Static::Help do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(action.call(params)).to be_success }
end
