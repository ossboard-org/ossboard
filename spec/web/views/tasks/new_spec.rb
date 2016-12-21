require_relative '../../../../apps/web/views/tasks/new'

RSpec.describe Web::Views::Tasks::New do
  let(:exposures) { Hash[params: {}] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tasks/new.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  describe '#form' do
    it { expect(view.form).to have_method(:post) }
    it { expect(view.form).to have_action('/tasks') }
  end

  describe 'nav bar actions' do
    it { expect(view.tasks_active?).to be true }
  end
end
