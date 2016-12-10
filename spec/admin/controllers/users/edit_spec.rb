require 'spec_helper'
require_relative '../../../../apps/admin/controllers/users/edit'

RSpec.describe Admin::Controllers::Users::Edit do
  let(:action) { described_class.new }
  let(:user) { UserRepository.new.create(name: 'test') }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }
  let(:params)  { { id: user.id, 'rack.session' => session } }

  after { TaskRepository.new.clear }

  it { expect(action.call(params)).to be_success }

  describe 'expose' do
    context '#user' do
      it 'returns user by id' do
        action.call(params)
        expect(action.user).to eq user
      end
    end
  end
end
