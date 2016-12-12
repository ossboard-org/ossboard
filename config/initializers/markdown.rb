require 'kramdown'
require 'rouge'

class Markdown
  def self.parse(text)
    ::Kramdown::Document.new(text, input: 'GFM',
        coderay_csscoderay_css: :class, syntax_highlighter: :rouge).to_html
  end
end
