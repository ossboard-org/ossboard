require_relative '../../../../apps/auth/controllers/sessions/failure'

RSpec.describe Auth::Controllers::Sessions::Failure do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
