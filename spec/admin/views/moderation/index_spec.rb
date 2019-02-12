require_relative '../../../../apps/admin/views/moderation/index'

RSpec.describe Admin::Views::Moderation::Index, type: :view do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/admin/templates/moderation/index.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:repo)      { TaskRepository.new }

  describe '#link_to_tasks' do
    let(:task) { Task.new(id: 1, title: 'Test') }
    it 'returns link to all tasks' do
      expect(view.link_to_task(task).to_s).to eq '<a href="/admin/tasks/1">Test</a>'
    end
  end

  describe '#tasks' do
    before do
      3.times { Fabricate.create(:task, title: 'good', approved: false) }
      3.times { Fabricate.create(:task, title: 'new', approved: nil) }
      3.times { Fabricate.create(:task, title: 'good', approved: true) }
    end

    it 'returns only not approved tasks' do
      expect(view.tasks.count).to eq 3
      expect(view.tasks.map(&:approved)).to eq [nil, nil, nil]
    end
  end

  describe '#approve_task_button' do
    let(:task) { Task.new(id: 1) }

    it { expect(view.approve_task_button(task)).to have_method(:patch) }
    it { expect(view.approve_task_button(task)).to have_action('/admin/moderation/1') }
  end

  describe 'nav bar actions' do
    it { expect(view.dashboard_active?).to be false }
    it { expect(view.moderation_active?).to be true }
    it { expect(view.tasks_active?).to be false }
    it { expect(view.users_active?).to be false }
  end
end
