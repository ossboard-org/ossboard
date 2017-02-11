require_relative '../../features_helper'

RSpec::Matchers.define :have_correct_switch_position do
  match { |switcher| switcher.has_active_link? && switcher.has_inactive_links? && switcher.has_elements? }

  failure_message do |switcher|
    errors = []
    errors << "Switcher active link #{switcher.active_link_description} not found" unless switcher.has_active_link?
    errors << "Switcher inactive links #{switcher.inactive_link_descriptions} not found" unless switcher.has_inactive_links?
    errors << "Switcher elements #{switcher.element_descriptions} not found" unless switcher.has_elements?
    errors.join("\n")
  end
end

class IndexPageSwitcher

  attr_accessor :active_position, :link_class, :active_link_class, :header_class

  def initialize(page, default_position = :left)
    @page = page
    @link_class = '.whatisthis-choice-item__link'
    @active_link_class = '.whatisthis-choice-item__link_active'
    @header_class = '.whatisthis-features-item__header'
    @positions = {
      left:  {text: 'I want to contribute', elements: ['Help Community', 'Build Your Profile', 'Get Involved']},
      right: {text: "I'm a maintainer",     elements: ['Manage your issues', 'Be open for new developers', "It's simple"]}
    }
    @active_position = @positions[default_position]
    @inactive_positions = @positions.reject { |k, _| k == default_position }
  end

  def position=(position)
    active_position_key, @active_position = @positions.detect { |_, pos| position == pos[:text] }
    @page.find(@link_class, text: @active_position[:text]).click
    @inactive_positions = @positions.reject { |k, _| k == active_position_key }
  end

  def link_description(position = nil)
    %Q("#{(position || @active_position)[:text]}" with CSS selector "#{@link_class}")
  end
  alias_method :active_link_description, :link_description

  def inactive_link_descriptions
    @inactive_positions.map { |position| link_description(position) }.join(', ')
  end

  def element_descriptions
    '"' + @active_position[:elements].join('", "') + '"'
  end

  def has_active_link?
    @page.has_css?(@active_link_class, text: @active_position[:text])
  end

  def has_inactive_links?
    @inactive_positions.all? { |_, position| @page.has_css?(@link_class, text: position[:text]) }
  end

  def has_elements?
    @active_position[:elements].all? { |element| @page.has_css?(@header_class, text: element) }
  end

end

RSpec.describe 'Index page', type: :feature, js: true do

  let(:switcher) { IndexPageSwitcher.new(page) }

  it 'switcher on index page with "I want to contribute" default switch position' do
    visit '/'

    expect(switcher).to have_correct_switch_position
  end

  it %q("I'm a maintainer" switch position and return to "I want to contribute" position) do
    visit '/'

    switcher.position = "I'm a maintainer"
    expect(switcher).to have_correct_switch_position

    switcher.position = 'I want to contribute'
    expect(switcher).to have_correct_switch_position
  end

end
