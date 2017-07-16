RSpec.describe Services::PointsCalculator do
  let(:user) { Fabricate.create(:user, login: 'davydovanton') }
  let(:service) { Services::PointsCalculator.new }
  subject { service.call(UserRepository.new.all_with_points_and_tasks.last) }

  after do
    TaskRepository.new.clear
    UserRepository.new.clear
    PointRepository.new.clear
  end

  describe '#perform' do
    context 'when user does not have tasks' do
      it 'does nothing' do
        user and subject
        point = PointRepository.new.points.where(user_id: user.id).first
        expect(point.maintainer).to eq 0
        expect(point.developer).to eq 0
      end
    end

    context 'when user have tasks' do
      context 'and tasks only in progress' do
        before do
          5.times { Fabricate.create(:task, user_id: user.id, status: 'in progress') }
        end

        it 'calculates points' do
          subject
          point = PointRepository.new.points.where(user_id: user.id).first
          expect(point.maintainer).to eq 5
          expect(point.developer).to eq 0
        end

        context 'when user have point object' do
          before do
            PointRepository.new.create(user_id: user.id)
          end

          it 'calculates points' do
            subject
            point = PointRepository.new.points.where(user_id: user.id).first
            expect(point.maintainer).to eq 5
            expect(point.developer).to eq 0
          end
        end
      end

      context 'and tasks with different status' do
        before do
          Fabricate.create(:task, user_id: user.id, status: 'in progress')
          Fabricate.create(:task, user_id: user.id, status: 'assigned')
          Fabricate.create(:task, user_id: user.id, status: 'closed')
          Fabricate.create(:task, user_id: user.id, status: 'done')
        end

        it 'calculates points' do
          subject
          point = PointRepository.new.points.where(user_id: user.id).first
          expect(point.maintainer).to eq 11
          expect(point.developer).to eq 0
        end
      end
    end

    context 'when user complete tasks' do
      context 'and tasks only in progress' do
        before do
          5.times { Fabricate.create(:task, assignee_username: user.login, status: 'in progress') }
        end

        it 'calculates points' do
          subject
          point = PointRepository.new.points.where(user_id: user.id).first
          expect(point.maintainer).to eq 0
          expect(point.developer).to eq 5
        end

        context 'when user have point object' do
          before do
            PointRepository.new.create(user_id: user.id)
          end

          it 'calculates points' do
            subject
            point = PointRepository.new.points.where(user_id: user.id).first
            expect(point.maintainer).to eq 0
            expect(point.developer).to eq 5
          end
        end
      end

      context 'and tasks with different status' do
        before do
          Fabricate.create(:task, assignee_username: user.login, status: 'in progress')
          Fabricate.create(:task, assignee_username: user.login, status: 'assigned')
          Fabricate.create(:task, assignee_username: user.login, status: 'closed')
          Fabricate.create(:task, assignee_username: user.login, status: 'done')
        end

        it 'calculates points' do
          subject
          point = PointRepository.new.points.where(user_id: user.id).first
          expect(point.maintainer).to eq 0
          expect(point.developer).to eq 11
        end
      end
    end
  end
end
