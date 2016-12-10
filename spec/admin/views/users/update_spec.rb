require_relative '../../../../apps/admin/views/users/update'

RSpec.describe Admin::Views::Users::Update do
  let(:exposures) { {} }
  let(:template)  { Hanami::View::Template.new('apps/admin/templates/users/edit.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  describe 'nav bar actions' do
    it { expect(view.dashboard_active?).to be false }
    it { expect(view.moderation_active?).to be false }
    it { expect(view.tasks_active?).to be false }
    it { expect(view.users_active?).to be true }
  end
end
