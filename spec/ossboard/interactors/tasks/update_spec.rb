# frozen_string_literal: true

RSpec.describe Interactors::Tasks::Update do
  let(:params_valid) { true }
  let(:current_user) { Fabricate.create(:user, login: 'davydovanton') }
  let(:task) { Fabricate.create(:task, user_id: current_user.id, status: 'in progress') }
  let(:params) do
    { id: task.id, task: { title: 'new_title_for_task', body: Faker::Lorem.sentence,
                           md_body: Faker::Lorem.sentence } }
  end
  let(:interactor) { Interactors::Tasks::Update }

  describe '#initialize' do
    it 'instantiates class with 2 arguments' do
      expect(interactor).to receive(:new).with(params_valid, params)
      interactor.new(params_valid, params)
    end
  end

  describe '#call' do
    context 'when @params_valid is true and task exists' do
      subject { interactor.new(params_valid, params) }
      it 'updates task with given params' do
        result = subject.call
        expect(TaskRepository.new.find(task.id).title).to eq params[:task][:title]
        expect(result.errors).to be_empty
        expect(result.success?).to be_truthy
      end
    end

    context 'when @params_valid is false' do
      subject { interactor.new(false, params) }
      it 'returns error' do
        result = subject.call
        expect(result.errors).to include('Unprocessable entity')
        expect(result.failure?).to be_truthy
      end
    end

    context 'when non-existent task id is provided' do
      subject { interactor.new(params_valid, params.merge(id: -1)) }
      it 'returns error' do
        result = subject.call
        expect(result.errors).to include('No task found')
        expect(result.failure?).to be_truthy
      end
    end
  end
end
