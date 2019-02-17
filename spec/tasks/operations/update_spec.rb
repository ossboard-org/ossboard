# frozen_string_literal: true

RSpec.describe Tasks::Operations::Update, type: :operation do
  let(:operation) { described_class.new(task_repo: task_repo, markdown_parser: markdown_parser) }
  let(:markdown_parser) { ->(body) { body } }
  let(:task_repo) { double('TaskRepository', find: Task.new, update: Task.new) }

  let(:body) { Faker::Hipster.sentence }
  let(:params) { { id: 1, task: { status: 'in_progress', md_body: body } } }

  subject { operation.call(is_valid, params) }

  context 'when payload is valid' do
    let(:is_valid) { true }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(Task.new) }

    it 'calls repository with all fields' do
      expect(task_repo).to receive(:update).with(1,
        status: 'in_progress',
        md_body: body,
        body: body,
      ).and_return(Task.new)

      subject
    end

    context 'when body is old' do
      let(:params) { { id: 1, task: { status: 'in_progress' } } }

      it 'calls repository with all fields' do
        expect(task_repo).to receive(:update).with(1, status: 'in_progress').and_return(Task.new)
        subject
      end
    end
  end

  context 'when payload is invalid' do
    let(:is_valid) { false }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq('Unprocessable entity') }

    it 'does not call repository' do
      expect(task_repo).to_not receive(:update)
      subject
    end
  end

  context 'when task not exist in the system' do
    let(:is_valid) { true }
    let(:task_repo) { double('TaskRepository', find: nil, update: Task.new) }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq('No task found') }

    it 'does not call repository' do
      expect(task_repo).to_not receive(:update)
      subject
    end
  end

  context 'which real dependencies' do
    let(:operation) { described_class.new }
    let(:params) { { id: task.id, task: { status: 'in_progress', md_body: Faker::Hipster.sentence, title: 'test_task_title' } } }
    let(:task) { Fabricate.create(:task, title: 'title')}

    subject { operation.call(true, params) }

    it { expect(subject).to be_success }
  end
end
