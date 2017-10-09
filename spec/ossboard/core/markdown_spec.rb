RSpec.describe Core::Markdown do
  let(:markdown){ Core::Markdown.new }
  subject { markdown.parse(body) }

  describe '#parse' do
    context 'when text contain heading' do
      let(:body){ '# title' }

      it { expect(subject).to eq %{<h1 id="title">title</h1>\n} }
    end

    context 'when text contain code tag' do
      let(:body){ '`title`' }

      it { expect(subject).to eq %{<p><code class="highlighter-rouge">title</code></p>\n} }
    end

    context 'when text contain em tag' do
      let(:body){ '*test*' }

      it { expect(subject).to eq "<p><em>test</em></p>\n" }
    end

    context 'when text contain strong tag' do
      let(:body){ '**test**' }

      it { expect(subject).to eq "<p><strong>test</strong></p>\n" }
    end

    context 'when text contain html tag' do
      let(:body){ '<strong>test</strong>' }

      it { expect(subject).to eq "<p><strong>test</strong></p>\n" }
    end

    context 'when text contain image' do
      let(:body){ '![violin](https://github.com)' }

      it { expect(subject).to eq "<p><img src=\"https://github.com\" alt=\"violin\" /></p>\n" }
    end

    context 'when text contain link tag' do
      let(:body){ '[google.com](https://google.com)' }

      it { expect(subject).to eq %{<p><a href="https://google.com">google.com</a></p>\n} }
    end

    context 'when text contain pure link' do
      let(:body){ 'https://google.com' }

      it { expect(subject).to eq %{<p><a href="https://google.com">https://google.com</a></p>\n} }
    end

    context 'when text contain checkbox tag' do
      let(:body){ '- [ ] checkkbox' }

      it 'replaces checkbox by html tag' do
        expect(subject).to eq %{<ul>\n  <li><input type="checkbox" disabled><label>checkkbox</label></li>\n</ul>\n}
      end
    end

    context 'when text contain checkbox tag' do
      let(:body){ '- [x] checkkbox' }

      it 'replaces checkbox by html tag' do
        expect(subject).to eq %{<ul>\n  <li><input type="checkbox" checked disabled><label>checkkbox</label></li>\n</ul>\n}
      end
    end
  end
end
