require_relative '../../features_helper'
require_relative '../../support/lib/page_switcher'

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
