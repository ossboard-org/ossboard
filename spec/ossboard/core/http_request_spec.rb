RSpec.describe Core::HttpRequest do
  let(:action) { described_class.new }

  describe '.get' do
    context 'when resource found' do
      let(:url) { 'https://www.ossboard.org' }
      it 'return status code 200' do
        VCR.use_cassette('ossboard_get_success') do
          expect(action.get(url).code).to eq '200'
        end
      end
    end

    context 'when resource not found' do
      let(:url) { 'https://www.ossboard.org/404' }
      it 'return status code 404' do
        VCR.use_cassette('ossboard_not_found') do
          expect(action.get(url).code).to eq '404'
        end
      end
    end

    context 'when retrieve specific task' do
      let(:url) { 'https://www.ossboard.org/' }
      let(:id) { '55' }
      it 'return specific task' do
        VCR.use_cassette('ossboard_retrieve_task') do
          expect(action.get(url + 'tasks/' + id).code).to eq '200'
        end
      end
    end
  end
end
