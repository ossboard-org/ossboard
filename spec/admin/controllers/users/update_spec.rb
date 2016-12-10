require 'spec_helper'
require_relative '../../../../apps/admin/controllers/users/update'

RSpec.describe Admin::Controllers::Users::Update do
  let(:action) { described_class.new }
  let(:repo)   { UserRepository.new }
  let(:user)   { repo.create(name: 'old') }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }

  after { repo.clear }

  describe 'when params valid' do
    let(:params) { { id: user.id, user: { name: 'test', login: 'test', email: 'test@test.com', bio: 'empty', admin: '1' }, 'rack.session' => session  } }

    it { expect(action.call(params)).to redirect_to("/admin/users/#{user.id}") }

    it 'updates new task' do
      action.call(params)
      user = repo.last
      expect(user.name).to eq 'test'
      expect(user.login).to eq 'test'
      expect(user.email).to eq 'test@test.com'
      expect(user.bio).to eq 'empty'
      expect(user.admin).to eq true
    end
  end

  describe 'when params invalid' do
    let(:params) { { id: user.id, 'rack.session' => session  } }

    it { expect(action.call(params)).to have_http_status(422) }

    it 'does not create new task' do
      action.call(params)
      user = repo.last
      expect(user.name).to eq 'old'
    end
  end
end
