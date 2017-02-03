RSpec.describe UrlShortener do
  subject { UrlShortener.call(url) }

  describe '#shorten_url' do
    context 'when link valid' do
      let(:url) { 'https://example.com' }

      it 'shortens url' do
        VCR.use_cassette("isgd_shortener_success") { expect(subject).to eq 'https://is.gd/jGamH3' }
      end
    end

    context 'when link invalid' do
      let(:url) { 'wrong url' }

      it "doesn't shorten invalid url" do
        VCR.use_cassette("isgd_shortener_fail") { expect(subject).to eq 'wrong url' }
      end
    end
  end
end
