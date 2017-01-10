require_relative '../../../../apps/api/controllers/md_preview/create'

RSpec.describe Api::Controllers::MdPreview::Create do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
