require_relative '../../../../apps/web/controllers/tasks/index'

RSpec.describe Web::Controllers::Tasks::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:repo) { TaskRepository.new }

  it { expect(action.call(params)).to be_success }

  describe 'expose' do
    describe '#tasks' do
      before do
        3.times { |i| repo.create(title: "title ##{i}", approved: true, status: 'done') }
        3.times { |i| repo.create(title: "title ##{i}", approved: true, status: 'closed') }
        3.times { |i| repo.create(title: "title ##{i}", approved: true, status: 'in progress') }
      end

      after { repo.clear }

      it 'returns all tasks' do
        action.call(params)
        expect(action.tasks).to eq repo.all
      end

      context 'when status param in done' do
        let(:params) { { status: 'done' } }

        it 'returns all done tasks' do
          action.call(params)
          expect(action.tasks).to all(be_a(Task))
          expect(action.tasks.count).to eq 3
        end
      end

      context 'when status param in closed' do
        let(:params) { { status: 'closed' } }

        it 'returns all closed tasks' do
          action.call(params)
          expect(action.tasks).to all(be_a(Task))
          expect(action.tasks.count).to eq 3
        end
      end

      context 'when status param in in progress' do
        let(:params) { { status: 'in progress' } }

        it 'returns all in progress tasks' do
          action.call(params)
          expect(action.tasks).to all(be_a(Task))
          expect(action.tasks.count).to eq 3
        end
      end
    end
  end
end
