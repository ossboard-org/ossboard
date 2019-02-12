require_relative '../../../../apps/admin/views/users/edit'

RSpec.describe Admin::Views::Users::Edit, type: :view do
  let(:user) { User.new(id: 1) }
  let(:exposures) { { user: user } }
  let(:template)  { Hanami::View::Template.new('apps/admin/templates/users/edit.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  describe '#form' do
    it { expect(view.form).to have_method(:patch) }
    it { expect(view.form).to have_action('/admin/users/1') }
  end

  describe '#checkbox_status' do
    context 'when user not approved' do
      it { expect(view.checkbox_status).to eq nil }
    end

    context 'when user approved' do
      let(:user) { User.new(id: 1, admin: true) }
      it { expect(view.checkbox_status).to eq 'checked' }
    end
  end

  describe 'nav bar actions' do
    it { expect(view.dashboard_active?).to be false }
    it { expect(view.moderation_active?).to be false }
    it { expect(view.tasks_active?).to be false }
    it { expect(view.users_active?).to be true }
  end
end
