require_relative '../../../../apps/web/controllers/task_status/update'

RSpec.describe Web::Controllers::TaskStatus::Update do
  let(:action) { described_class.new }

  let(:repo) { TaskRepository.new }
  let(:task) { Fabricate.create(:task, title: 'old', status: 'in progress', user_id: user.id) }
  let(:user) { Fabricate.create(:user, name: 'Anton') }

  let(:session) { { current_user: user } }
  let(:params) { { id: task.id, status: status, 'rack.session' => session  } }

  let(:status) { 'in progress' }

  it { expect(action.call(params)).to redirect_to("/tasks/#{task.id}") }

  context 'when current user is not author of task' do
    let(:task) { Fabricate.create(:task, title: 'old', status: 'in progress', user_id: nil) }
    it 'does nothig' do
      action.call(params)
      expect(repo.find(task.id).status).to eq 'in progress'
    end
  end

  context 'when task status is not "in progress"' do
    let(:task) { Fabricate.create(:task, title: 'old', status: 'done', user_id: user.id) }
    it 'does nothig' do
      action.call(params)
      expect(repo.find(task.id).status).to eq 'done'
    end
  end

  context 'when task status invalid' do
    let(:task) { Fabricate.create(:task, title: 'old', status: 'in progress', user_id: user.id) }
    let(:status) { 'invalid' }

    it 'does nothig' do
      action.call(params)
      expect(repo.find(task.id).status).to eq 'in progress'
    end
  end

  context 'when all is okay' do
    let(:task) { Fabricate.create(:task, title: 'old', status: 'in progress', user_id: user.id) }
    let(:status) { 'done' }

    it 'does nothig' do
      action.call(params)
      expect(repo.find(task.id).status).to eq 'done'
    end
  end

  context 'when all is okay' do
    let(:task) { Fabricate.create(:task, title: 'old', status: 'assigned', user_id: user.id) }
    let(:status) { 'done' }

    it 'does nothig' do
      action.call(params)
      expect(repo.find(task.id).status).to eq 'done'
    end
  end

  context 'when all is okay' do
    let(:task) { Fabricate.create(:task, title: 'old', status: 'in progress', user_id: user.id) }
    let(:status) { 'assigned' }
    let(:params) { { id: task.id, status: status, assignee_username: username, 'rack.session' => session  } }

    context 'when username is empty' do
      let(:username) { '' }

      it 'does nothig' do
        action.call(params)
        updated_task = repo.find(task.id)
        expect(updated_task.status).to eq 'assigned'
        expect(updated_task.assignee_username).to eq ''
      end
    end

    context 'when username is set' do
      let(:username) { 'davydovanton' }

      it 'does nothig' do
        action.call(params)
        updated_task = repo.find(task.id)
        expect(updated_task.status).to eq 'assigned'
        expect(updated_task.assignee_username).to eq 'davydovanton'
      end
    end
  end
end
