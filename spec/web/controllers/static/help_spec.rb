require_relative '../../../../apps/web/controllers/static/help'

RSpec.describe Web::Controllers::Static::Help do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
