require_relative '../../../../apps/web/controllers/tasks/index'

RSpec.describe Web::Controllers::Tasks::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:repo) { TaskRepository.new }

  it { expect(action.call(params)).to be_success }

  describe 'expose' do
    describe '#tasks' do
      before do
        3.times { |i| repo.create(title: "title ##{i}", approved: true) }
      end

      after { repo.clear }

      it 'returns all tasks' do
        action.call(params)
        expect(action.tasks).to eq repo.all
      end
    end
  end
end
