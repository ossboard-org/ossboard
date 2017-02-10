require_relative '../../../../apps/web/controllers/tasks/edit'

RSpec.describe Web::Controllers::Tasks::Edit do
  let(:action)  { described_class.new }
  let(:user)    { Fabricate.create(:user, name: 'anton') }
  let(:session) { { current_user: User.new } }
  let(:repo)    { TaskRepository.new }
  let(:task)    { Fabricate.create(:task, title: 'TestTask') }
  let(:params)  { { 'rack.session' => session, id: task.id } }

  after { repo.clear }

  context 'when user unauthenticated' do
    it { expect(action.call(params)).to redirect_to("/tasks/#{task.id}") }

    it 'sets error flash message' do
      action.call(params)
      flash = action.exposures[:flash]
      expect(flash[:error]).to eq "You doesn't have access for editing this task"
    end
  end

  context 'when user authenticated and try to edit not its task' do
    let(:task)    { Fabricate.create(:task, title: 'TestTask', user_id: user.id) }
    let(:session) { { current_user: User.new(id: user.id - 1) } }

    after do
      UserRepository.new.clear
      repo.clear
    end

    it { expect(action.call(params)).to redirect_to("/tasks/#{task.id}") }

    it 'sets error flash message' do
      action.call(params)
      flash = action.exposures[:flash]
      expect(flash[:error]).to eq "You doesn't have access for editing this task"
    end
  end

  context 'when user authenticated and try to edit approved task' do
    let(:task)    { Fabricate.create(:task, title: 'TestTask', user_id: user.id, approved: true) }
    let(:session) { { current_user: user } }

    after do
      UserRepository.new.clear
      repo.clear
    end

    it { expect(action.call(params)).to redirect_to("/tasks/#{task.id}") }

    it 'sets error flash message' do
      action.call(params)
      flash = action.exposures[:flash]
      expect(flash[:error]).to eq "You doesn't have access for editing this task"
    end
  end

  context 'when user unauthenticated' do
    let(:task)    { Fabricate.create(:task, title: 'TestTask', user_id: user.id, approved: false) }
    let(:session) { { current_user: user } }

    it { expect(action.call(params)).to have_http_status(:success) }

    describe 'expose' do
      context '#task' do
        it 'returns task by id' do
          action.call(params)
          expect(action.task).to eq task
        end
      end

      context '#params' do
        it 'returns action params' do
          action.call(params)
          expect(action.params).to be_a Hanami::Action::BaseParams
        end
      end
    end
  end
end
