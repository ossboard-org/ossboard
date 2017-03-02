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

  context 'when md text has link without protocol' do
    let(:params) { { md_text: 'Bingo-bongo! test google.com' } }
    it { expect(action.call(params)).to be_success }
    it { expect(action.call(params).last).to eq ['{"text":"<p>Bingo-bongo! test <a href=\"google.com\">google.com</a></p>\n"}'] }
  end

  context 'when md text has link with protocol' do
    let(:params) { { md_text: 'Bingo-bongo! test http://google.com ' } }
    it { expect(action.call(params)).to be_success }
    it { expect(action.call(params).last).to eq ['{"text":"<p>Bingo-bongo! test <a href=\"http://google.com\">http://google.com</a></p>\n"}'] }
  end

  context 'when md text has link with params' do
    let(:params) { { md_text: 'Bingo-bongo! test http://google.com/?q=12354 ' } }
    it { expect(action.call(params)).to be_success }
    it { expect(action.call(params).last).to eq ['{"text":"<p>Bingo-bongo! test <a href=\"http://google.com/?q=12354\">http://google.com/?q=12354</a></p>\n"}'] }
  end

  context 'when md text has md link with brackets' do
    let(:params) { { md_text: 'Bingo-bongo! test <http://google.com> ' } }
    it { expect(action.call(params)).to be_success }
    it { expect(action.call(params).last).to eq ['{"text":"<p>Bingo-bongo! test <a href=\"http://google.com\">http://google.com</a></p>\n"}'] }
  end

  context 'when md text has md link' do
    let(:params) { { md_text: 'Bingo-bongo! test [http://google.com](http://google.com) ' } }
    it { expect(action.call(params)).to be_success }
    it { expect(action.call(params).last).to eq ['{"text":"<p>Bingo-bongo! test <a href=\"http://google.com\">http://google.com</a></p>\n"}'] }
  end
end
