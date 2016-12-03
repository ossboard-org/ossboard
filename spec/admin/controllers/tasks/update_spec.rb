require 'spec_helper'
require_relative '../../../../apps/web/controllers/tasks/create'

RSpec.describe Admin::Controllers::Tasks::Update do
  let(:action) { described_class.new }
  let(:repo) { TaskRepository.new }
  let(:task) { repo.create(title: 'old') }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }

  after { repo.clear }

  describe 'when params valid' do
    let(:params) { { id: task.id, task: { title: 'test', body: 'long body', approved: '1' }, 'rack.session' => session  } }

    it { expect(action.call(params)).to redirect_to("/admin/tasks/#{task.id}") }

    it 'updates new task' do
      action.call(params)
      task = repo.last
      expect(task.title).to eq 'test'
      expect(task.body).to eq 'long body'
      expect(task.approved).to eq true
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
