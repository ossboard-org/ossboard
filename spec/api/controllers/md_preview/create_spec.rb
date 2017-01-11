require_relative '../../../../apps/api/controllers/md_preview/create'

RSpec.describe Api::Controllers::MdPreview::Create do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  # expect(task.md_body).to eq 'This is *bongos*, indeed.'

  it { expect(action.call(params)).to be_success }
  it { expect(action.call(params)).to match_in_body(/\A{"text":""}\z/) }

  context 'when md text is empty' do
    let(:params) { { md_text: '' } }

    it { expect(action.call(params)).to be_success }
    it { expect(action.call(params)).to match_in_body(/\A{"text":""}\z/) }
  end
end
