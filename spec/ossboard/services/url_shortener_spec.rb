RSpec.describe UrlShortener do
  subject { UrlShortener.new }

  describe '#shorten_url' do
    it 'shortens valid url' do
      VCR.use_cassette("isgd_shortener_success") do
        url = subject.shorten_url('https://example.com')
        expect(url).to eq 'https://is.gd/jGamH3'
      end
    end

    it "doesn't shorten invalid url" do
      VCR.use_cassette("isgd_shortener_fail") do
        url = subject.shorten_url('wrong url')
        expect(url).to eq 'wrong url'
      end
    end
  end
end
