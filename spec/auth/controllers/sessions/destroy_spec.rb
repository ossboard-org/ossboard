require_relative '../../../../apps/auth/controllers/sessions/destroy'

RSpec.describe Auth::Controllers::Sessions::Destroy do
  let(:action) { described_class.new }
  let(:params)  { { 'rack.session' => session } }

  context 'when session is empty' do
    let(:session) { { current_user: nil } }

    it 'does nothing' do
      action.call(params)
      expect(action.session[:current_user]).to be nil
    end

    it { expect(action.call(params)).to redirect_to('/') }
  end

  context 'when session is not empty' do
    let(:session) { { current_user: User.new(id: 1, admin: true) } }

    it 'deletes session value' do
      action.call(params)
      expect(action.session[:current_user]).to be nil
    end

    it { expect(action.call(params)).to redirect_to('/') }
  end

  context 'when current_path sets' do
    let(:session) { { current_user: nil, current_path: '/tasks' } }
    it { expect(action.call(params)).to redirect_to('/tasks') }
  end
end
