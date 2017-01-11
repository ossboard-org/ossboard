require_relative '../../../../apps/api/controllers/md_preview/create'

RSpec.describe Api::Controllers::MdPreview::Create do
  let(:action) { described_class.new }
  let(:params) { {} }

  it { expect(action.call(params)).to be_success }
  it { expect(action.call(params).last).to eq ['{"text":""}'] }

  context 'when md text is empty' do
    let(:params) { { md_text: '' } }

    it { expect(action.call(params)).to be_success }
    it { expect(action.call(params).last).to eq ['{"text":""}'] }
  end

  context 'when md text is empty' do
    let(:params) { { md_text: 'This is *bongos*, indeed.' } }

    it { expect(action.call(params)).to be_success }
    it { expect(action.call(params).last).to eq ['{"text":"<p>This is <em>bongos</em>, indeed.</p>\n"}'] }
  end
end
