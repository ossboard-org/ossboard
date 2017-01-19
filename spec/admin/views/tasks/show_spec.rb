require_relative '../../../../apps/admin/views/tasks/show'

RSpec.describe Admin::Views::Tasks::Show do
  let(:template)  { Hanami::View::Template.new('apps/admin/templates/tasks/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  let(:task) { Task.new(id: 1, title: 'test') }
  let(:exposures) { Hash[task: task] } 

  describe '#link_to_edit' do
    it 'returns link to special task' do
      link = view.link_to_edit
      expect(link.to_s).to eq '<a class="pure-button pure-button-primary" href="/admin/tasks/1/edit">Edit task</a>'
    end
  end

  describe 'nav bar actions' do
    it { expect(view.dashboard_active?).to be false }
    it { expect(view.moderation_active?).to be false }
    it { expect(view.tasks_active?).to be true }
    it { expect(view.users_active?).to be false }
  end

  describe '#task_label' do
    context 'when task approved' do
      let(:task) { Task.new(id: 1, title: 'test', approved: true) }
      it { expect(view.task_label.to_s).to eq "<span class=\"label label-success\">\nApproved\n</span>" }
    end

    context 'when task in waiting status' do
      let(:task) { Task.new(id: 1, title: 'test', approved: nil) }
      it { expect(view.task_label.to_s).to eq "<span class=\"label\">\nWaiting\n</span>" }
    end

    context 'when task not approved' do
      let(:task) { Task.new(id: 1, title: 'test', approved: false) }
      it { expect(view.task_label.to_s).to eq "<span class=\"label label-danger\">\nUnapproved\n</span>" }
    end
  end

  describe '#link_to_assignee' do
    let(:task) { Task.new(assignee_username: 'davydovanton') }
    it { expect(view.link_to_assignee.to_s).to eq '<a href="/users/davydovanton">davydovanton</a>' }
  end

  describe '#link_to_issue' do
    context 'when task have issue link' do
      let(:task) { Task.new(issue_url: 'test.com') }
      it { expect(view.link_to_issue.to_s).to eq '<a target="_blank" href="test.com">test.com</a>' }
    end

    context "when task doesn't have issue link" do
      let(:task) { Task.new(issue_url: nil) }
      it { expect(view.link_to_issue.to_s).to eq 'None' }
    end
  end
end
