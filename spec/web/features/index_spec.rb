require_relative '../../features_helper'

module IndexPageSwitcher

  def expect_i_want_to_contribute
    expect(page).to have_css('.whatisthis-choice-item__link_active', text: 'I want to contribute')
    expect(page).to have_css('.whatisthis-choice-item__link', text: "I'm a maintainer")
    expect_headers('Help Community', 'Build Your Profile', 'Get Involved')
  end

  def expect_im_a_maintainer
    expect(page).to have_css('.whatisthis-choice-item__link_active', text: "I'm a maintainer")
    expect(page).to have_css('.whatisthis-choice-item__link', text: 'I want to contribute')
    expect_headers('Manage your issues', 'Be open for new developers', "It's simple")
  end

  def expect_headers(*headers)
    expect(headers).to satisfy { |h| h.all? { |text| page.has_css?('.whatisthis-features-item__header', text: text) } }
  end

end

RSpec.describe 'Index page', type: :feature, js: true do
  include IndexPageSwitcher

  it 'renders meta tags' do
    visit '/'

    expect(page).to have_selector('title', text: 'OSSBoard', visible: false)
    expect(page).to have_css('meta[name="description"]', visible: false)
  end

  it 'switcher on index page with "I want to contribute" default switch position' do
    visit '/'

    expect_i_want_to_contribute
  end

  it %q("I'm a maintainer" switch position and return to "I want to contribute" position) do
    visit '/'

    page.find('.whatisthis-choice-item__link', text: "I'm a maintainer").click
    expect_im_a_maintainer

    page.find('.whatisthis-choice-item__link', text: 'I want to contribute').click
    expect_i_want_to_contribute
  end
end
