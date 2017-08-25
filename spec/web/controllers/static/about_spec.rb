require_relative '../../../../apps/web/controllers/static/about'

RSpec.describe Web::Controllers::Static::About do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(action.call(params)).to be_success }
end
