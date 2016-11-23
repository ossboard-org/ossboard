require 'spec_helper'
require_relative '../../../../apps/web/controllers/tasks/create'

RSpec.describe Web::Controllers::Tasks::Create do
  let(:action) { described_class.new }
  let(:repo) { TaskRepository.new }

  after { repo.clear }

  describe 'when params valid' do
    let(:params) { { task: { title: 'test', body: 'long body' } } }

    it { expect(action.call(params)).to redirect_to('/') }

    it 'creates new task' do
      expect { action.call(params) }.to change { repo.all.size }.by(1)

      task = repo.last
      expect(task.title).to eq 'test'
      expect(task.body).to eq 'long body'
    end
  end

  describe 'when params invalid' do
    let(:params) { {} }

    it { expect(action.call(params)).to have_http_status(422) }

    it 'does not create new task' do
      expect { action.call(params) }.to change { repo.all.size }.by(0)
    end
  end
end
