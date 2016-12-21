require 'spec_helper'
require_relative '../../../../apps/web/views/tasks/show'

RSpec.describe Web::Views::Tasks::Show do
  let(:exposures) { { current_user: current_user, author: user, task: task } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tasks/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:current_user) { User.new(id: 1, name: 'test', email: 'test@ossboard.com') }
  let(:user) { User.new(id: 2, name: 'test', email: 'test@ossboard.com') }
  let(:task) { Task.new(id: 1, title: 'task title') }

  describe 'nav bar actions' do
    it { expect(view.tasks_active?).to be true }
  end

  describe '#link_to_author' do
    it 'returns link to special user' do
      link = view.link_to_author
      expect(link.to_s).to eq '<a href="/users/2">test</a>'
    end
  end

  describe '#contact_with_mentor_link' do
    it 'returns link to special user' do
      link = view.contact_with_mentor_link
      expect(link.to_s).to eq '<a class="btn btn-contact task__contact" href="mailto:test@ossboard.com?subject=OSSBoard: task title">Contact with mentor</a>'
    end
  end

  describe '#link_to_original_issue' do
    subject { view.link_to_original_issue.to_s }

    context 'when task have issue link' do
      let(:task) { Task.new(id: 1, issue_url: 'github.com') }
      it { expect(subject).to eq '<a target="_blank" href="github.com">(Original issue)</a>' }
    end

    context 'when issue link empty' do
      let(:task) { Task.new(id: 1, issue_url: '') }
      it { expect(subject).to eq '' }
    end

    context 'when task does not have issue link' do
      let(:task) { Task.new(id: 1, issue_url: nil) }
      it { expect(subject).to eq '' }
    end
  end

  describe '#task_status_actions' do
    subject { view.task_status_actions.to_s }

    context 'when not task author open page' do
      let(:task) { Task.new(id: 1, user_id: 5) }
      it { expect(subject).to eq '' }
    end

    context 'when task author open page' do
      let(:task) { Task.new(id: 1, user_id: 1, status: 'in progress') }
      it { expect(subject).to eq "<div class=\"task__status\">\n" +
           "<form action=\"/task_status/1\" method=\"POST\">\n" +
           "<input type=\"hidden\" name=\"_method\" value=\"PATCH\">\n" +
           "<input type=\"hidden\" name=\"status\" value=\"done\">\n" +
           "<input class=\"btn btn-done\" type=\"submit\" value=\"Complited\">\n" +
           "</form>\n" +
           "<form action=\"/task_status/1\" method=\"POST\">\n" +
           "<input type=\"hidden\" name=\"_method\" value=\"PATCH\">\n" +
           "<input type=\"hidden\" name=\"status\" value=\"closed\">\n" +
           "<input class=\"btn btn-close\" type=\"submit\" value=\"Closed\">\n" +
           "</form>\n" +
           "</div>" }
    end

    context 'when task is not in in_progress pstatus' do
      let(:task) { Task.new(id: 1, user_id: 1, status: 'closed') }
      it { expect(subject).to eq '' }
    end
  end
end
