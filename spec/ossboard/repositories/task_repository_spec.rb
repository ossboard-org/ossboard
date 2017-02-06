RSpec.describe TaskRepository do
  let(:repo) { TaskRepository.new }

  describe '#find_by' do
    after { repo.clear }

    before do
      Fabricate.create(:task, title: 'in progress', approved: true, status: 'in progress', lang: 'ruby')
      Fabricate.create(:task, title: 'closed', approved: true, status: 'closed', lang: 'haskell')
      Fabricate.create(:task, title: 'done', approved: true, status: 'done', lang: 'unknown')
    end

    context 'when params is empty' do
      it 'returns array of closed tasks' do
        result = repo.find_by
        expect(result).to all(be_a(Task))
        expect(result.count).to eq 3
      end
    end

    context 'when status is closed' do
      it 'returns array of closed tasks' do
        result = repo.find_by(status: 'closed')
        expect(result).to all(be_a(Task))
        expect(result.count).to eq 1
        expect(result.first.status).to eq 'closed'
      end
    end

    context 'when status is done' do
      it 'returns array of done tasks' do
        result = repo.find_by(status: 'done')
        expect(result).to all(be_a(Task))
        expect(result.count).to eq 1
        expect(result.first.status).to eq 'done'
      end
    end

    context 'when status is in progress' do
      it 'returns array of in progress tasks' do
        result = repo.find_by(status: 'in progress')
        expect(result).to all(be_a(Task))
        expect(result.count).to eq 1
        expect(result.first.status).to eq 'in progress'
      end
    end

    context 'when lang is ruby' do
      it 'returns array of ruby language tasks' do
        result = repo.find_by(lang: 'ruby')
        expect(result).to all(be_a(Task))
        expect(result.count).to eq 1
        expect(result.first.lang).to eq 'ruby'
      end
    end

    context 'when lang is haskell' do
      it 'returns array of haskell language tasks' do
        result = repo.find_by(lang: 'haskell')
        expect(result).to all(be_a(Task))
        expect(result.count).to eq 1
        expect(result.first.lang).to eq 'haskell'
      end
    end

    context 'when lang is unknown' do
      it 'returns array of unknown language tasks' do
        result = repo.find_by(lang: 'unknown')
        expect(result).to all(be_a(Task))
        expect(result.count).to eq 1
        expect(result.first.lang).to eq 'unknown'
      end
    end

    context 'when status is in progress and lang is ruby' do
      it 'returns array of in progress, ruby tasks' do
        result = repo.find_by(status: 'in progress', lang: 'ruby')
        expect(result).to all(be_a(Task))
        expect(result.count).to eq 1
        expect(result.first.lang).to eq 'ruby'
        expect(result.first.status).to eq 'in progress'
      end
    end
  end

  describe '#only_approved' do
    after { repo.clear }

    before do
      Fabricate.create(:task, title: 'bad')
      Fabricate.create(:task, title: 'good', approved: true)
    end

    it 'returns only approved tasks' do
      result = repo.only_approved
      expect(result).to all(be_a(Task))
      expect(result.size).to eq 1
      expect(result.last.title).to eq 'good'
    end
  end

  describe '#on_moderation_for_user' do
    after { repo.clear }

    before do
      Fabricate.create(:task, title: 'good', approved: nil, user_id: user.id)
      Fabricate.create(:task, title: 'good', approved: nil)
      Fabricate.create(:task, title: 'good', approved: false)
    end

    let(:user) { Fabricate.create(:user, name: 'anton') }

    it 'returns array of tasks' do
      result = repo.on_moderation_for_user(user.id)
      expect(result).to all(be_a(Task))
      expect(result.count).to eq 1
      expect(result.last.user_id).to eq user.id
    end
  end

  describe '#not_approved' do
    after { repo.clear }

    before do
      Fabricate.create(:task, title: 'bad')
      Fabricate.create(:task, title: 'new',  approved: nil)
      Fabricate.create(:task, title: 'good', approved: true)
    end

    it 'returns not approved tasks' do
      result = repo.not_approved
      expect(result).to all(be_a(Task))
      expect(result.size).to eq 1
      expect(result.last.title).to eq 'bad'
    end
  end

  describe '#new_tasks' do
    after { repo.clear }

    before do
      Fabricate.create(:task, title: 'bad')
      Fabricate.create(:task, title: 'new',  approved: nil)
      Fabricate.create(:task, title: 'good', approved: true)
    end

    it 'returns not approved tasks' do
      result = repo.new_tasks
      expect(result).to all(be_a(Task))
      expect(result.size).to eq 1
      expect(result.last.title).to eq 'new'
    end
  end

  describe '#all_from_date' do
    before(:all) do
      3.times do |i|
        random_days_count = i * 60 * 60 * 24
        Timecop.freeze(Time.new(2016, 02, 20) - random_days_count) do
          Fabricate.create(:task, status: 'done')
          Fabricate.create(:task, status: 'in progress')
          Fabricate.create(:task, status: 'closed')
          Fabricate.create(:task, status: 'assigned')
        end
      end

      Timecop.freeze(Time.now + (2 * 60 * 60 * 24)) { Fabricate.create(:task) }
    end

    describe '#all_from_date_counted_by_status_and_day' do
      before(:all) do
        3.times do |i|
          Timecop.freeze(Time.utc(2016, 02, 20 + i)) do
            Fabricate.create(:task, status: 'done')
            Fabricate.create(:task, status: 'in progress')
            Fabricate.create(:task, status: 'closed')
            Fabricate.create(:task, status: 'assigned')
          end
        end
      end

      let (:result) { repo.all_from_date_counted_by_status_and_day(Time.new(2016, 02, 20)) }

      it { expect(result).to be_a(Hash) }
      it { expect(result['done'].count).to eq 2 }
      it { expect(result.dig('closed', Date.new(2016, 02, 22))).to eq 1 }
    end

    after(:all) { TaskRepository.new.clear }

    let(:date) { Date.new(2016, 02, 18) }

    it 'returns array of tasks' do
      expect(repo.all_from_date(date)).to be_a(Array)
      expect(repo.all_from_date(date).count).to eq 8
    end
    it { expect(repo.all_from_date(date, 'in progress').count).to eq 2 }
    it { expect(repo.all_from_date(date, 'done').count).to eq 2 }
    it { expect(repo.all_from_date(date, 'closed').count).to eq 2 }
    it { expect(repo.all_from_date(date, 'assigned').count).to eq 2 }
  end

  describe '#on_moderation_for_user' do
    after { repo.clear }

    before do
      Fabricate.create(:task, assignee_username: 'davydovanton')
      Fabricate.create(:task, assignee_username: 'davydovanton')
      Fabricate.create(:task, assignee_username: 'test')
    end

    let(:user) { User.new(login: 'davydovanton') }

    it 'returns array of tasks' do
      result = repo.assigned_tasks_for_user(user)
      expect(result).to all(be_a(Task))
      expect(result.count).to eq 2
    end
  end
end
