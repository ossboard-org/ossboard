require_relative '../../../../apps/admin/controllers/dashboard/index'

RSpec.describe Admin::Controllers::Dashboard::Index do
  let(:action)  { described_class.new }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }
  let(:params)  { { 'rack.session' => session } }

  context 'when admin login' do
    it 'is successful' do
      response = action.call(params)
      expect(response[0]).to eq 200
    end
  end

  context 'when admin login' do
    let(:params) { {} }

    it 'is successful' do
      response = action.call(params)
      expect(response[0]).to eq 302
    end
  end
end
