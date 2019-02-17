# frozen_string_literal: true

RSpec.describe Tasks::Operations::Create, type: :operation do
  require 'sidekiq/testing' 
  Sidekiq::Testing.fake! # fake is the default mode

  let(:operation) { described_class.new(task_repo: task_repo, markdown_parser: markdown_parser) }
  let(:markdown_parser) { ->(body) { body } }
  let(:task_repo) { double('TaskRepository', create: Task.new) }

  let(:body) { Faker::Hipster.sentence }
  let(:params) { { task: { status: 'in_progress', md_body: body, title: 'test_task_title' } } }

  subject { operation.call(is_valid, params) }

  context 'when payload is valid' do
    let(:is_valid) { true }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(Task.new) }

    it { expect{ subject }.to change(NewTaskNotificationWorker.jobs, :size).by(1) }

    it 'calls repository with all fields' do
      expect(task_repo).to receive(:create).with(
        status: 'in progress',
        md_body: body,
        title: 'test_task_title',
        body: body,
        approved: nil
      ).and_return(Task.new)

      subject
    end
  end

  context 'when payload is invalid' do
    let(:is_valid) { false }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq('invalid task attributes') }

    it { expect{ subject }.to change(NewTaskNotificationWorker.jobs, :size).by(0) }

    it 'does not call repository' do
      expect(task_repo).to_not receive(:create)
      subject
    end
  end

  context 'which real dependencies' do
    let(:operation) { described_class.new }
    let(:params) { { task: { status: 'in_progress', md_body: Faker::Hipster.sentence, title: 'test_task_title' } } }

    subject { operation.call(true, params) }

    it { expect(subject).to be_success }
  end
end
