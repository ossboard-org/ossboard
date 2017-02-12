class PageSwitcher

  attr_accessor :errors

  def initialize(page, default_position = :left)
    @page, @errors = page, []
    after_initialize if respond_to?(:after_initialize)
    set_default_position(default_position)
  end

  def position=(position)
    active_position_key, @active_position = @positions.detect { |_, pos| position == pos[:text] }
    @page.find(@link_selector, text: @active_position[:text]).click
    @inactive_positions = @positions.reject { |k, _| k == active_position_key }
  end

  def has_active_link?
    @page.has_css?(@active_link_selector, text: @active_position[:text]) || error('Active link not found')
  end

  def has_inactive_links?
    @inactive_positions.all? { |_, position| @page.has_css?(@link_selector, text: position[:text]) } || error('Inactive link(s) not found')
  end

  def has_elements?
    @active_position[:elements].all? { |element| @page.has_css?(element[:selector], text: element[:text]) } || elements_error
  end

  def error(text)
    (@errors << text) && false
  end

  def elements_error
    error('Switch position elements not found')
  end

  protected

  def set_default_position(default_position)
    @active_position = @positions[default_position]
    @inactive_positions = @positions.reject { |k, _| k == default_position }
  end

end

class IndexPageSwitcher < PageSwitcher

  def after_initialize
    @link_selector = '.whatisthis-choice-item__link'
    @active_link_selector = '.whatisthis-choice-item__link_active'

    sel = '.whatisthis-features-item__header'
    left = ['Help Community', 'Build Your Profile', 'Get Involved'].map { |text| {selector: sel, text: text} }
    right = ['Manage your issues', 'Be open for new developers', "It's simple"].map { |text| {selector: sel, text: text} }

    @positions = {left: {text: 'I want to contribute', elements: left}, right: {text: "I'm a maintainer", elements: right}}
  end

end

class TasksPageSwitcher < PageSwitcher

  def after_initialize
    @link_selector = 'button.btn.btn-default.pure-menu-link'

    md_text = File.read(File.expand_path('../../markdown/text.md', __FILE__))
    md_html = File.read(File.expand_path('../../markdown/text.html', __FILE__))

    left = {selector: '.task-body__write > #task-md-body', value: md_text}
    right = {selector: '#previewed-text', text: md_html}

    @page.find(left[:selector]).set md_text

    @positions = {left: {text: 'Write', elements: left}, right: {text: 'Preview', elements: right}}
  end

  def has_active_link?
    @page.has_no_css?(@link_selector, text: @active_position[:text]) || error(%Q(Button "#{@active_position[:text]}" should not exist, but presented))
  end

  def has_elements?
    sel = @active_position[:elements][:selector]

    if @active_position == @positions[:left]
      @page.find(sel).value == @active_position[:elements][:value]
    else
      @page.find(sel + ' > :first-child') && @page.find(sel)['innerHTML'] == @active_position[:elements][:text]
    end || elements_error
  end

end

RSpec::Matchers.define(:have_correct_switch_position) do
  match { |switcher| switcher.has_active_link? && switcher.has_inactive_links? && switcher.has_elements? }
  failure_message { |switcher| switcher.errors.join("\n") }
end
