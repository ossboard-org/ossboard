require_relative '../../../../apps/web/views/tasks/show'

RSpec.describe Web::Views::Tasks::Show do
  let(:exposures) { { current_user: current_user, author: user, task: task } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tasks/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:current_user) { User.new(id: 1, name: 'test', email: 'test@ossboard.com') }
  let(:user) { User.new(id: 2, login: 'davydovanton', name: 'test', email: 'test@ossboard.com') }
  let(:task) { Task.new(id: 1, title: 'task title') }

  describe '#title' do
    it { expect(view.title).to eq 'OSSBoard: task title' }
  end

  describe 'nav bar actions' do
    it { expect(view.tasks_active?).to be true }
  end

  describe '#author_information' do
    context 'when user have name' do
      it 'returns link to special user' do
        link = view.author_information
        expect(link.to_s).to eq "<div class=\"task__author\">\n" +
          "Posted by\n" +
          "<a href=\"/users/davydovanton\">\n" +
          "<img class=\"task__author-avatar\" src=\"\">\n" +
          "test\n" +
          "</a>\n" +
          "3 weeks ago\n" +
          "</div>"
      end
    end

    context "when user doesn't have name" do
      let(:user) { User.new(id: 2, login: 'login', email: 'test@ossboard.com') }

      it 'returns link to special user' do
        link = view.author_information
        expect(link.to_s).to eq "<div class=\"task__author\">\n" +
          "Posted by\n" +
          "<a href=\"/users/login\">\n" +
          "<img class=\"task__author-avatar\" src=\"\">\n" +
          "login\n" +
          "</a>\n" +
          "3 weeks ago\n" +
          "</div>"
      end
    end
  end

  describe '#link_to_edit_task' do
    context 'when user not authenticated' do
      let(:current_user) { User.new }

      it 'returns emty string' do
        link = view.link_to_edit_task
        expect(link.to_s).to eq ''
      end
    end

    context 'when user not author of task' do
      let(:task) { Task.new(id: 1, title: 'task title', user_id: 5) }

      it 'returns emty string' do
        link = view.link_to_edit_task
        expect(link.to_s).to eq ''
      end
    end

    context 'when task approved' do
      let(:task) { Task.new(id: 1, title: 'task title', user_id: 1, approved: true) }

      it 'returns emty string' do
        link = view.link_to_edit_task
        expect(link.to_s).to eq ''
      end
    end

    context 'when task not approved and authenticated user is author of this task' do
      let(:task) { Task.new(id: 1, title: 'task title', user_id: 1, approved: false) }

      it 'returns link to edit' do
        link = view.link_to_edit_task
        expect(link.to_s).to eq '<a class="btn btn-back" href="/tasks/1/edit">Edit</a>'
      end
    end
  end

  describe '#link_to_author' do
    let(:task) { Task.new(status: 'done') }
    it { expect(view.task_status.to_s).to eq "<span>\n(done)\n</span>" }

    context 'when task in progress' do
      let(:task) { Task.new(status: 'in progress') }
      it { expect(view.task_status.to_s).to eq '' }
    end
  end

  describe '#contact_with_mentor_link' do
    it 'returns link to special user' do
      link = view.contact_with_mentor_link
      expect(link.to_s).to eq '<a target="_blank" class="contact-mentor-link" href="https://gitter.im/davydovanton">Contact mentor (Gitter)</a>'
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
      context 'and task status "in progress"' do
        let(:task) { Task.new(id: 1, user_id: 1, status: 'in progress') }

        it { expect(subject).to eq "<div class=\"task__status\">\n" +
             "<form action=\"/task_status/1\" method=\"POST\">\n" +
             "<input type=\"hidden\" name=\"_method\" value=\"PATCH\">\n" +
             "<input type=\"hidden\" name=\"status\" value=\"assigned\">\n" +
             "<input name=\"assignee_username\" value=\"\" placeholder=\"Assignee @github\" class=\"assign-user\">\n" +
             "<input class=\"btn btn-assign\" type=\"submit\" value=\"Assign\">\n" +
             "</form>\n" +
             "</div>" }
      end

      context 'and task status "assigned"' do
        let(:task) { Task.new(id: 1, user_id: 1, status: 'assigned') }

        it { expect(subject).to eq "<div class=\"task__status\">\n" +
             "<form action=\"/task_status/1\" method=\"POST\">\n" +
             "<input type=\"hidden\" name=\"_method\" value=\"PATCH\">\n" +
             "<input type=\"hidden\" name=\"status\" value=\"done\">\n" +
             "<input class=\"btn btn-done\" type=\"submit\" value=\"Completed\">\n" +
             "</form>\n" +

             "<form action=\"/task_status/1\" method=\"POST\">\n" +
             "<input type=\"hidden\" name=\"_method\" value=\"PATCH\">\n" +
             "<input type=\"hidden\" name=\"status\" value=\"closed\">\n" +
             "<input class=\"btn btn-close\" type=\"submit\" value=\"Closed\">\n" +
             "</form>\n" +
             "</div>" }
      end
    end

    context 'when task is not in in_progress pstatus' do
      let(:task) { Task.new(id: 1, user_id: 1, status: 'closed') }
      it { expect(subject).to eq '' }
    end
  end

  describe '#complexity_label' do
    context 'for easy level' do
      let(:task) { Task.new(id: 1, complexity: 'easy') }
      it { expect(view.complexity_label.to_s).to eq "<span class=\"level level-easy\">\nEASY\n</span>" }
    end

    context 'for medium level' do
      let(:task) { Task.new(id: 1, complexity: 'medium') }
      it { expect(view.complexity_label.to_s).to eq "<span class=\"level level-medium\">\nMEDIUM\n</span>" }
    end

    context 'for hard level' do
      let(:task) { Task.new(id: 1, complexity: 'hard') }
      it { expect(view.complexity_label.to_s).to eq "<span class=\"level level-hard\">\nHARD\n</span>" }
    end
  end
end
