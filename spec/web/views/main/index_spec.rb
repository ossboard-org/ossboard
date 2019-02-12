require_relative '../../../../apps/web/views/main/index'

RSpec.describe Web::Views::Main::Index, type: :view do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/main/index.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  let(:repo) { TaskRepository.new }

  describe '#title' do
    it { expect(view.title).to eq 'OSSBoard' }
  end

  describe '#description' do
    it { expect(view.description).to be }
  end

  describe '#link_to_tasks' do
    it 'returns link to all tasks' do
      expect(view.link_to_tasks.to_s).to eq '<a class="issues-all__link" href="/tasks">View all</a>'
    end
  end

  describe '#link_to_new_tasks' do
    it 'returns link to new task form' do
      expect(view.link_to_new_tasks.to_s).to eq '<a class="btn" href="/tasks/new">Submit Task</a>'
    end
  end

  describe '#link_to_task' do
    let(:task) { Task.new(id: 1, title: 'test') }

    it 'returns link to special task' do
      link = view.link_to_task(task)
      expect(link.to_s).to eq '<a class="btn" href="/tasks/1">Open task</a>'
    end
  end

  describe '#tasks_active?' do
    it { expect(view.tasks_active?).to be false }
  end
end
