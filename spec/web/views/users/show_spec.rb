require_relative '../../../../apps/web/views/users/show'

RSpec.describe Web::Views::Users::Show do
  let(:user)      { User.new(login: 'anton') }
  let(:exposures) { Hash[user: user] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/users/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  describe '#title' do
    it { expect(view.title).to eq 'OSSBoard: anton' }
  end

  describe '#link_to_task' do
    context 'when task approved' do
      let(:task) { Task.new(id: 1, title: 'test', approved: true) }

      it 'returns link to special task' do
        link = view.link_to_task(task)
        expect(link.to_s).to eq '<a href="/tasks/1">test</a>'
      end
    end

    context 'when task not approved' do
      let(:task) { Task.new(id: 1, title: 'test', approved: false) }

      it 'returns task title' do
        link = view.link_to_task(task)
        expect(link.to_s).to eq "<span>\ntest\n</span>"
      end
    end
  end

  describe '#task_status_style' do
    context 'when task approved' do
      let(:task) { Task.new(id: 1, title: 'test', approved: true) }
      it { expect(view.task_status_style(task).to_s).to eq '' }
    end

    context 'when task not approved' do
      let(:task) { Task.new(id: 1, title: 'test', approved: false) }
      it { expect(view.task_status_style(task).to_s).to eq 'waiting-task' }
    end
  end
end
