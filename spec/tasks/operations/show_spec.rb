# frozen_string_literal: true

RSpec.describe Tasks::Operations::Show, type: :operation do
  let(:operation) { described_class.new(task_repo: task_repo) }

  subject { operation.call(id: 1) }

  context 'when task exists in the system' do
    let(:task_repo) { double('TaskRepository', find: Task.new) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq Task.new }
  end

  context 'when task does not exist in the system' do
    let(:task_repo) { double('TaskRepository', find: nil) }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq :not_found }
  end

  context 'with real dependencies' do
    let(:operation) { described_class.new }
    let(:task) { Fabricate.create(:task, title: 'title')}

    subject { operation.call(id: task.id) }

    it { expect(subject).to be_success }
  end
end
