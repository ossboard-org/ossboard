require 'spec_helper'
require_relative '../../../../apps/web/controllers/tasks/create'

RSpec.describe Web::Controllers::Tasks::Create do
  let(:action) { described_class.new }
  let(:repo) { TaskRepository.new }
  let(:session) { { current_user: User.new(id: 1) } }

  after { repo.clear }

  describe 'when user in not authenticated' do
    let(:params) { { task: { title: 'test', body: 'long body' } } }

    it { expect(action.call(params)).to have_http_status(200) }

    it 'does not create new task' do
      expect { action.call(params) }.to change { repo.all.size }.by(0)
    end
  end

  describe 'when params valid' do
    let(:params) { { task: { title: 'test', body: 'long body' }, 'rack.session' => session } }

    it { expect(action.call(params)).to redirect_to('/tasks') }

    it 'creates new task' do
      expect { action.call(params) }.to change { repo.all.size }.by(1)

      task = repo.last
      expect(task.title).to eq 'test'
      expect(task.body).to eq 'long body'
    end
  end

  describe 'when params invalid' do
    let(:params) { { task: { 'rack.session' => session } } }

    it { expect(action.call(params)).to have_http_status(200) }
    it { expect(action.call(params)).to match_in_body('Title is missing') }
    it { expect(action.call(params)).to match_in_body(/Body is missing/) }

    it 'does not create new task' do
      expect { action.call(params) }.to change { repo.all.size }.by(0)
    end
  end
end
