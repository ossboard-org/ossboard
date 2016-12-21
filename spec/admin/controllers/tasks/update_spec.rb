require_relative '../../../../apps/web/controllers/tasks/create'

RSpec.describe Admin::Controllers::Tasks::Update do
  let(:action) { described_class.new }
  let(:repo) { TaskRepository.new }
  let(:task) { repo.create(title: 'old') }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }

  after { repo.clear }

  describe 'when params valid' do
    let(:params) { { id: task.id, task: { title: 'test', md_body: 'This is *bongos*, indeed.', approved: '1', lang: 'ruby', issue_url: 'github.com/issue/1', status: 'done' }, 'rack.session' => session  } }

    it { expect(action.call(params)).to redirect_to("/admin/tasks/#{task.id}") }

    it 'updates new task' do
      action.call(params)
      task = repo.last
      expect(task.title).to eq 'test'
      expect(task.md_body).to eq 'This is *bongos*, indeed.'
      expect(task.body).to eq "<p>This is <em>bongos</em>, indeed.</p>\n"
      expect(task.approved).to eq true
      expect(task.lang).to eq 'ruby'
      expect(task.issue_url).to eq 'github.com/issue/1'
      expect(task.status).to eq 'done'
    end

    context 'and issue url empty' do
      let(:params) { { id: task.id, task: { title: 'test', md_body: 'This is *bongos*, indeed.', approved: '1', lang: 'ruby', issue_url: '', status: 'done' }, 'rack.session' => session  } }

      it { expect(action.call(params)).to redirect_to("/admin/tasks/#{task.id}") }

      it 'updates new task' do
        action.call(params)
        task = repo.last
        expect(task.title).to eq 'test'
        expect(task.md_body).to eq 'This is *bongos*, indeed.'
        expect(task.body).to eq "<p>This is <em>bongos</em>, indeed.</p>\n"
        expect(task.approved).to eq true
        expect(task.lang).to eq 'ruby'
        expect(task.issue_url).to eq nil
      end
    end
  end

  describe 'when params invalid' do
    let(:params) { { id: task.id, 'rack.session' => session  } }

    it { expect(action.call(params)).to have_http_status(422) }

    it 'does not create new task' do
      action.call(params)
      task = repo.last
      expect(task.title).to eq 'old'
      expect(task.body).to eq nil
    end
  end
end
