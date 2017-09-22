# frozen_string_literal: true

RSpec.describe Tasks::Interactors::UpdateStatus do
  let(:current_user) { Fabricate.create(:user, login: 'davydovanton') }
  let(:task) { Fabricate.create(:task, user_id: current_user.id, status: 'in progress') }
  let(:params) { { id: task.id, status: 'closed' } }
  let(:interactor) { described_class }

  describe '#initialize' do
    it 'instantiates class with 2 arguments' do
      expect(interactor).to receive(:new).with(current_user, params)
      interactor.new(current_user, params)
    end
  end

  describe '#call' do
    context 'when params are valid' do
      subject { interactor.new(current_user, params) }
      it 'updates task with given params' do
        subject.call
        expect(TaskRepository.new.find(params[:id]).status).to eq('closed')
      end
    end

    context 'when params are not valid' do
      subject { interactor.new(current_user, params.merge(status: 'invalid_status')) }
      it 'does not update task' do
        subject.call
        expect(TaskRepository.new.find(params[:id]).status).to eq('in progress')
      end
    end
  end
end
