RSpec.describe Core::Markdown do
  let(:markdown){ Core::Markdown.new() }
  let(:body){ '*test*' }
  subject { markdown.parse(body) }

  it { expect(subject).to eq("<p><em>test</em></p>\n") }

  context 'image' do
    let(:body){ '![violin](https://github.com)' }
    it { expect(subject).to eq("<p><img src=\"https://github.com\" alt=\"violin\" /></p>\n") }
  end

  context 'links' do
    let(:body){ '[google.com](https://google.com)' }
    it { expect(subject).to eq(%{<p><a href="https://google.com">google.com</a></p>\n}) }
  end

  context 'link from text' do
    let(:body){ 'https://google.com' }
    it { expect(subject).to eq(%{<p><a href="https://google.com">https://google.com</a></p>\n}) }
  end
end
