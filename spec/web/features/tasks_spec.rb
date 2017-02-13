require_relative '../../features_helper'

module TasksPageSwitcher

  def fill_md_text
    page.find('.task-body__write > #task-md-body').set md_text
  end

  def expect_write
    expect(page).to have_css('button.btn.btn-default.pure-menu-link', text: 'Preview')
    expect(page).not_to have_css('button.btn.btn-default.pure-menu-link', text: 'Write')
    expect(page.find('.task-body__write > #task-md-body').value).to eq(md_text)
  end

  def expect_preview
    md_html = File.read(File.expand_path('../../../support/markdown/text.html', __FILE__))
    expect(page).to have_css('button.btn.btn-default.pure-menu-link', text: 'Write')
    expect(page).not_to have_css('button.btn.btn-default.pure-menu-link', text: 'Preview')
    page.find('#previewed-text > :first-child') && page.find('#previewed-text')['innerHTML'] == md_html
  end

end

RSpec.describe 'Tasks page', type: :feature, js: true do

  include TasksPageSwitcher

  let(:md_text) { File.read(File.expand_path('../../../support/markdown/text.md', __FILE__)) }

  describe '#new' do

    it 'switcher on new page with "Description" default switch position' do
      visit '/tasks/new'

      fill_md_text
      expect_write
    end

    it '"Preview" switch position and return to "Description" position' do
      visit '/tasks/new'

      fill_md_text

      page.find('button.btn.btn-default.pure-menu-link', text: 'Preview').click
      expect_preview

      page.find('button.btn.btn-default.pure-menu-link', text: 'Write').click
      expect_write
    end

  end

end
