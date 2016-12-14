require_relative '../../../../apps/admin/views/users/show'

RSpec.describe Admin::Views::Users::Show do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/admin/templates/users/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    expect(view.foo).to eq exposures.fetch(:foo)
  end

  describe '#link_to_task' do
    let(:task) { Task.new(id: 1, title: 'test') }

    it 'returns link to special task' do
      link = view.link_to_task(task)
      expect(link.to_s).to eq '<a href="/admin/tasks/1">test</a>'
    end
  end

  describe '#task_label' do
    context 'when task approved' do
      let(:task) { Task.new(id: 1, title: 'test', approved: true) }
      it { expect(view.task_label(task).to_s).to eq "<span class=\"label label-success\">\nApproved\n</span>" }
    end

    context 'when task not approved' do
      let(:task) { Task.new(id: 1, title: 'test', approved: false) }
      it { expect(view.task_label(task).to_s).to eq "<span class=\"label label-danger\">\nUnapproved\n</span>" }
    end
  end
end
