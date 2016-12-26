require_relative '../../../../apps/web/views/tasks/edit'

RSpec.describe Web::Views::Tasks::Edit do
  let(:exposures) { Hash[params: {}, task: Task.new(id: 1)] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tasks/edit.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  describe '#title' do
    it { expect(view.title).to eq 'OSSBoard: edit task' }
  end

  describe '#form' do
    it { expect(view.form).to have_method(:patch) }
    it { expect(view.form).to have_action('/tasks/1') }
  end

  describe 'nav bar actions' do
    it { expect(view.tasks_active?).to be true }
  end
end
