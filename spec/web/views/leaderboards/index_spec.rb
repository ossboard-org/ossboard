require_relative '../../../../apps/web/views/leaderboards/index'

RSpec.describe Web::Views::Leaderboards::Index, type: :view do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/leaderboards/index.html.slim') }
  let(:user)      { User.new(id: 1, admin: false, login: 'whatever', avatar_url: 'test_url') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  describe 'exposes' do
    describe '#user_information' do
      let(:info) { view.user_information(user) }
      
      # it { expect(info).to have_css('.user-row__name', count: 1) }
      # it { expect(info).to have_css('.user-row__avatar', count: 1) }
      # it { expect(info).to have_selector(:css, 'a[href="/users/whatever"]') }
      # it { expect(info).to have_selector(:css, 'img[src="test_url"]') }
      # it { expect(info).to have_content(user.login, count: 1) }
    end
  end
end
