RSpec.describe Core::MarkdownParser do
  let(:markdown){ described_class.new }
  subject { markdown.call(text) }

  describe '#parse' do
    context 'when text contain heading' do
      let(:text){ '# title' }

      it { expect(subject).to eq %{<h1 id="title">title</h1>\n} }
    end

    context 'when text contain code tag' do
      let(:text){ '`title`' }

      it { expect(subject).to eq %{<p><code class="highlighter-rouge">title</code></p>\n} }
    end

    context 'when text contain em tag' do
      let(:text){ '*test*' }

      it { expect(subject).to eq "<p><em>test</em></p>\n" }
    end

    context 'when text contain strong tag' do
      let(:text){ '**test**' }

      it { expect(subject).to eq "<p><strong>test</strong></p>\n" }
    end

    context 'when text contain html tag' do
      let(:text){ '<strong>test</strong>' }

      it { expect(subject).to eq "<p><strong>test</strong></p>\n" }
    end

    context 'when text contain image' do
      let(:text){ '![violin](https://github.com)' }

      it { expect(subject).to eq "<p><img src=\"https://github.com\" alt=\"violin\" /></p>\n" }
    end

    context 'when text contain link tag' do
      let(:text){ '[google.com](https://google.com)' }

      it { expect(subject).to eq %{<p><a href="https://google.com">google.com</a></p>\n} }
    end

    context 'when text contain pure link' do
      let(:text){ 'https://google.com' }

      it { expect(subject).to eq %{<p><a href="https://google.com">https://google.com</a></p>\n} }
    end

    context 'when text contain checkbox tag' do
      let(:text){ '- [ ] checkkbox' }

      it 'replaces checkbox by html tag' do
        expect(subject).to eq %{<ul>\n  <li><input type="checkbox" disabled><label>checkkbox</label></li>\n</ul>\n}
      end
    end

    context 'when text contain checkbox tag' do
      let(:text){ '- [x] checkkbox' }

      it 'replaces checkbox by html tag' do
        expect(subject).to eq %{<ul>\n  <li><input type="checkbox" checked disabled><label>checkkbox</label></li>\n</ul>\n}
      end
    end
  end
end
