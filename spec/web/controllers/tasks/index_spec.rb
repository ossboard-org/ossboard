require_relative '../../../../apps/web/controllers/tasks/index'

RSpec.describe Web::Controllers::Tasks::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:repo) { TaskRepository.new }

  it { expect(action.call(params)).to be_success }

  describe 'expose' do
    before { action.call(params) }

    describe '#tasks' do
      before do
        3.times { |i| Fabricate.create(:task, title: "title ##{i}", approved: true, status: 'done') }
        3.times { |i| Fabricate.create(:task, title: "title ##{i}", approved: true, status: 'closed') }
        3.times { |i| Fabricate.create(:task, title: "title ##{i}", approved: true, status: 'in progress') }
        action.call(params)
      end

      after { repo.clear }

      it 'returns all tasks' do
        expect(action.tasks).to all(be_a(Task))
        expect(action.tasks.count).to eq 3
      end

      context 'when status param in done' do
        let(:user) { Fabricate.create(:user, admin: false) }
        let(:params)  { { 'rack.session' => { current_user: user }, status: 'moderation' } }

        before do
          3.times { |i| Fabricate.create(:task, approved: false, user_id: user.id) }
          action.call(params)
        end

        it 'returns all done tasks' do
          expect(action.tasks).to all(be_a(Task))
          expect(action.tasks.count).to eq 3
          expect(action.tasks.map(&:user_id)).to all(eq(user.id))
        end
      end

      context 'when status param in done' do
        let(:params) { { status: 'done' } }

        it 'returns all done tasks' do
          expect(action.tasks).to all(be_a(Task))
          expect(action.tasks.count).to eq 3
          expect(action.tasks.map(&:status)).to all(eq('done'))
        end
      end

      context 'when status param invalid' do
        let(:params) { { status: 'invalid' } }

        it 'returns all done tasks' do
          expect(action.tasks).to all(be_a(Task))
          expect(action.tasks.count).to eq 3
          expect(action.tasks.map(&:status)).to all(eq('in progress'))
        end
      end

      context 'when status param in closed' do
        let(:params) { { status: 'closed' } }

        it 'returns all closed tasks' do
          expect(action.tasks).to all(be_a(Task))
          expect(action.tasks.count).to eq 3
          expect(action.tasks.map(&:status)).to all(eq('closed'))
        end
      end

      context 'when status param in in progress' do
        let(:params) { { status: 'in progress' } }

        it 'returns all in progress tasks' do
          expect(action.tasks).to all(be_a(Task))
          expect(action.tasks.count).to eq 3
          expect(action.tasks.map(&:status)).to all(eq('in progress'))
        end
      end
    end
  end
end
