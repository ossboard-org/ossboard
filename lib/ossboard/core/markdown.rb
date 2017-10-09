require 'kramdown'
require 'rouge'
require 'rinku'


module Core
  class Markdown
    CHECKBOX_REGEXP_CHECKED = %r(\K\[(x|X)\]\s?(.*)<)
    CHECKBOX_REGEXP_UNCHECKED = %r(\K\[ \]\s?(.*)<)

    def parse(text)
      html = ::Kramdown::Document.new(text,
                                      input: 'GFM',
                                      coderay_csscoderay_css: :class,
                                      syntax_highlighter: :rouge).to_html
      html = html.gsub(CHECKBOX_REGEXP_CHECKED, %(<input type="checkbox" checked disabled><label>\\2</label><))
        .gsub(CHECKBOX_REGEXP_UNCHECKED, %(<input type="checkbox" disabled><label>\\1</label><))

      Rinku.auto_link(html)
    end
  end
end
