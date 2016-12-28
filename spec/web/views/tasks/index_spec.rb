require_relative '../../../../apps/web/views/tasks/index'

RSpec.describe Web::Views::Tasks::Index do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tasks/index.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  describe '#title' do
    it { expect(view.title).to eq 'OSSBoard: tasks' }
  end

  describe '#link_to_task' do
    let(:task) { Task.new(id: 1, title: 'test') }

    it 'returns link to special task' do
      link = view.link_to_task(task)
      expect(link.to_s).to eq '<a href="/tasks/1">test</a>'
    end
  end

  describe 'nav bar actions' do
    it { expect(view.tasks_active?).to be true }
  end

  describe '#task_statuses' do
    it { expect(view.task_statuses).to eq('in progress' => 'In progress', 'assigned' => 'Assigned', 'closed' => 'Closed', 'done' => 'Finished') }
  end

  describe '#status_selected_class' do
    let(:exposures) { { params: { status: 'test' } } }
    it { expect(view.status_selected_class('test')).to eq('pure-menu-selected') }
    it { expect(view.status_selected_class('invalid')).to eq(nil) }
  end
end
