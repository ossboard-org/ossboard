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
    it { expect(view.task_statuses).to eq('in progress' => 'Open', 'assigned' => 'Assigned', 'closed' => 'Closed', 'done' => 'Finished') }
  end

  describe '#tasks_languages' do
    it do
      expect(view.task_languages).to eq(
        'any' => 'language',
        'unknown' => 'unknown',
        'ruby' => 'ruby',
        'js' => 'javascript',
        'java' => 'java',
        'python' => 'python',
        'go' => 'go',
        'haskell' => 'haskell',
        'lua' => 'lua',
        'scala' => 'scala',
        'elixir' => 'elixir',
        'rust' => 'rust',
        'clojure' => 'clojure',
        'php' => 'php',
        'crystal' => 'crystal'
      )
    end
  end

  describe '#complexity_label' do
    context 'for easy level' do
      let(:task) { Task.new(id: 1, complexity: 'easy') }
      it { expect(view.complexity_label(task).to_s).to eq "<span class=\"level level-easy\">\nEASY\n</span>" }
    end

    context 'for medium level' do
      let(:task) { Task.new(id: 1, complexity: 'medium') }
      it { expect(view.complexity_label(task).to_s).to eq "<span class=\"level level-medium\">\nMEDIUM\n</span>" }
    end

    context 'for hard level' do
      let(:task) { Task.new(id: 1, complexity: 'hard') }
      it { expect(view.complexity_label(task).to_s).to eq "<span class=\"level level-hard\">\nHARD\n</span>" }
    end
  end

  describe '#select_tasks_by_status' do
    context 'when tasks status is empty' do
      let(:exposures) { { params: { }, current_user: User.new } }
      it 'returns select form' do
        expect(view.select_tasks_by_status.to_s).to eq "<select id=\"task-status-select\" @change=\"changeStatus($event)\">\n" +
          "<option value=\"in progress\" selected=\"selected\">Open</option>\n" +
          "<option value=\"assigned\">Assigned</option>\n" +
          "<option value=\"closed\">Closed</option>\n" +
          "<option value=\"done\">Finished</option>\n" +
        "</select>"
      end
    end

    context 'when current user registered' do
      let(:exposures) { { params: { }, current_user: User.new(id: 1) } }
      it 'returns select form' do
        expect(view.select_tasks_by_status.to_s).to eq "<select id=\"task-status-select\" @change=\"changeStatus($event)\">\n" +
          "<option value=\"in progress\" selected=\"selected\">Open</option>\n" +
          "<option value=\"assigned\">Assigned</option>\n" +
          "<option value=\"closed\">Closed</option>\n" +
          "<option value=\"done\">Finished</option>\n" +
          "<option value=\"moderation\">On moderation</option>\n" +
        "</select>"
      end
    end

    context 'when tasks status is closed' do
      let(:exposures) { { params: { status: 'closed' }, current_user: User.new } }
      it 'returns select form' do
        expect(view.select_tasks_by_status.to_s).to eq "<select id=\"task-status-select\" @change=\"changeStatus($event)\">\n" +
          "<option value=\"in progress\">Open</option>\n" +
          "<option value=\"assigned\">Assigned</option>\n" +
          "<option value=\"closed\" selected=\"selected\">Closed</option>\n" +
          "<option value=\"done\">Finished</option>\n" +
        "</select>"
      end
    end

    context 'when tasks status is closed and user registered' do
      let(:exposures) { { params: { status: 'moderation' }, current_user: User.new(id: 1) } }
      it 'returns select form' do
        expect(view.select_tasks_by_status.to_s).to eq "<select id=\"task-status-select\" @change=\"changeStatus($event)\">\n" +
          "<option value=\"in progress\">Open</option>\n" +
          "<option value=\"assigned\">Assigned</option>\n" +
          "<option value=\"closed\">Closed</option>\n" +
          "<option value=\"done\">Finished</option>\n" +
          "<option value=\"moderation\" selected=\"selected\">On moderation</option>\n" +
        "</select>"
      end
    end

    describe '#select_tasks_by_language' do
      context 'when tasks language is empty' do
        let(:exposures) { { params: { }, current_user: User.new } }

        it 'returns select form' do
          expect(view.select_tasks_by_language.to_s).to eq "<select id=\"task-language-select\" @change=\"changeLang($event)\">\n" +
                "<option value=\"any\" selected=\"selected\">language</option>\n" +
                "<option value=\"unknown\">unknown</option>\n" +
                "<option value=\"ruby\">ruby</option>\n" +
                "<option value=\"js\">javascript</option>\n" +
                "<option value=\"java\">java</option>\n" +
                "<option value=\"python\">python</option>\n" +
                "<option value=\"go\">go</option>\n" +
                "<option value=\"haskell\">haskell</option>\n" +
                "<option value=\"lua\">lua</option>\n" +
                "<option value=\"scala\">scala</option>\n" +
                "<option value=\"elixir\">elixir</option>\n" +
                "<option value=\"rust\">rust</option>\n" +
                "<option value=\"clojure\">clojure</option>\n" +
                "<option value=\"php\">php</option>\n" +
                "<option value=\"crystal\">crystal</option>\n" +
               "</select>"
        end
      end

      context 'when tasks language is unknown' do
        let(:exposures) { { params: { lang: 'unknown' }, current_user: User.new } }

        it 'returns select form' do
          expect(view.select_tasks_by_language.to_s).to eq "<select id=\"task-language-select\" @change=\"changeLang($event)\">\n" +
                "<option value=\"any\">language</option>\n" +
                "<option value=\"unknown\" selected=\"selected\">unknown</option>\n" +
                "<option value=\"ruby\">ruby</option>\n" +
                "<option value=\"js\">javascript</option>\n" +
                "<option value=\"java\">java</option>\n" +
                "<option value=\"python\">python</option>\n" +
                "<option value=\"go\">go</option>\n" +
                "<option value=\"haskell\">haskell</option>\n" +
                "<option value=\"lua\">lua</option>\n" +
                "<option value=\"scala\">scala</option>\n" +
                "<option value=\"elixir\">elixir</option>\n" +
                "<option value=\"rust\">rust</option>\n" +
                "<option value=\"clojure\">clojure</option>\n" +
                "<option value=\"php\">php</option>\n" +
                "<option value=\"crystal\">crystal</option>\n" +
               "</select>"
        end
      end

      describe '#author_information' do
        let(:author) { User.new(login: 'testtest', avatar_url: 'test_url') }
        let(:task) { Task.new(lang: 'ru', created_at: Time.now) }

        it 'renders' do
          expect(view.author_information(author, task).to_s).to eq"<div class=\"task-item__author\">\n" + 
              "Posted by\n" + 
              "<a href=\"/users/testtest\">\n" + 
                "<img class=\"task-item__author-avatar\" src=\"test_url\">\n" + 
                "testtest\n" + 
              "</a>\n" + 
              "less than a minute\n" + 
              " • ru\n" + 
            "</div>"
        end
      end
    end
  end
end
