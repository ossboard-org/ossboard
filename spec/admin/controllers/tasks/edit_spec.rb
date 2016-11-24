require_relative '../../../../apps/admin/controllers/tasks/edit'

RSpec.describe Admin::Controllers::Tasks::Edit do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
