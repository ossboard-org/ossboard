require_relative '../../../../apps/web/controllers/tasks/edit'

RSpec.describe Web::Controllers::Tasks::Edit do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
