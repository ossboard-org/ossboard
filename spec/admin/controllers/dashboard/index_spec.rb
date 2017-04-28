require_relative '../../../../apps/admin/controllers/dashboard/index'

RSpec.describe Admin::Controllers::Dashboard::Index do
  let(:action)  { described_class.new }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }
  let(:params)  { { 'rack.session' => session } }

  context 'when admin login' do
    it { expect(action.call(params)).to be_success }
  end

  context 'when admin logout' do
    let(:params) { {} }

    it { expect(action.call(params)).to redirect_to('/') }
  end
end
