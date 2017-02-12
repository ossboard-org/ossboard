require_relative '../../features_helper'
require_relative '../../support/lib/page_switcher'

RSpec.describe 'Tasks page', type: :feature, js: true do

  describe '#new' do

    let(:text) { File.read(File.expand_path('../../support/text.md', __FILE__)) }
    let(:switcher) { TasksPageSwitcher.new(page) }

    it 'switcher on new page with "Description" default switch position' do
      visit '/tasks/new'

      expect(switcher).to have_correct_switch_position
    end

    it '"Preview" switch position and return to "Description" position' do
      visit '/tasks/new'

      switcher.position = 'Preview'
      expect(switcher).to have_correct_switch_position

      switcher.position = 'Write'
      expect(switcher).to have_correct_switch_position
    end

  end

end
