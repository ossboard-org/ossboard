require_relative '../../../../apps/admin/views/tasks/edit'

RSpec.describe Admin::Views::Tasks::Edit do
  let(:task)      { Task.new(id: 1, title: 'test', body: 'test') }
  let(:exposures) { Hash[task: task] }
  let(:template)  { Hanami::View::Template.new('apps/admin/templates/tasks/edit.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  describe '#form' do
    it { expect(view.form).to have_method(:patch) }
    it { expect(view.form).to have_action('/admin/tasks/1') }
  end
end
