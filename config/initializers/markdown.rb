require 'kramdown'
require 'rouge'

class Markdown
  LINK_REGEXP = %r((?<![=["|']|><a-z0-9_\.])(?<!http:\/\/)((http[s]?\:\/\/)?([a-z0-9\.]+\.[a-z]{2,5}(\/[\?=&a-z0-9_\.\/]+)?)))

  def self.parse(text)
    html = ::Kramdown::Document.new(text,
                                    input: 'GFM',
                                    coderay_csscoderay_css: :class,
                                    syntax_highlighter: :rouge).to_html
    html.gsub(LINK_REGEXP, '<a href="\1">\1</a>')
  end
end
