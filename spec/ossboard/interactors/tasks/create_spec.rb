# frozen_string_literal: true

RSpec.describe Interactors::Tasks::Create do
  let(:is_valid) { true }
  let(:params) { { task: { status: 'in_progress', md_body: Faker::Hipster.sentence, title: 'test_task_title' } } }
  let(:interactor) { Interactors::Tasks::Create }

  describe '#initialize' do
    it 'instantiates class with 2 arguments' do
      expect(interactor).to receive(:new).with(is_valid, params)
      interactor.new(is_valid, params)
    end
  end

  describe '#call' do
    context 'when @is_valid is true' do
      subject { interactor.new(is_valid, params) }
      it 'creates new task' do
        result = subject.call
        expect(TaskRepository.new.last.title).to eq params[:task][:title]
        expect(result.errors).to be_empty
        expect(result.success?).to be_truthy
      end
    end

    context 'when @is_valid is false' do
      subject { interactor.new(false, params) }
      it 'returns error' do
        result = subject.call
        expect(result.errors).to include('invalid task attributes')
        expect(result.failure?).to be_truthy
      end
    end
  end
end
