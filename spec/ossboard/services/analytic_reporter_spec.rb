RSpec.describe Services::AnalyticReporter do
  subject { Services::AnalyticReporter.new.call }

  context 'labels information' do
    it 'returns array of days for chart labels' do
      labels = subject[:labels]
      expect(labels).to be_a(Array)
      expect(labels.count).to eq 31
      expect(labels).to all(be_a(String))
      expect(labels.last).to eq Date.today.to_s
      expect(labels.first).to eq (Date.today - 30).to_s
    end
  end

  context 'users information' do
    it 'returns array of zeros' do
      users = subject[:users]
      expect(users).to be_a(Array)
      expect(users.count).to eq 31
      expect(users).to all(be == 0)
    end

    context 'when users was created' do
      before do
        Timecop.freeze(Time.now.utc - 60) do
          3.times { Fabricate.create(:user) }
        end
        Timecop.freeze(Time.now.utc)
      end

      after { Timecop.return }

      it 'returns array with user count' do
        users = subject[:users]
        expect(users.uniq.count).to eq 2
        expect(users.last).to eq 3
      end
    end
  end

  context 'tasks information' do
    it 'returns empty arrays for each task statuse' do
      tasks = subject[:tasks]

      expect(tasks).to be_a(Hash)
      expect(tasks.keys).to eq %i[in_progress assigned closed done]
      expect(tasks[:in_progress].count).to eq 31
      expect(tasks[:assigned].count).to eq 31
      expect(tasks[:closed].count).to eq 31
      expect(tasks[:done].count).to eq 31

      expect(tasks[:in_progress]).to all(be == 0)
      expect(tasks[:assigned]).to all(be == 0)
      expect(tasks[:closed]).to all(be == 0)
      expect(tasks[:done]).to all(be == 0)
    end

    context 'when users was created' do
      before do
        Timecop.freeze(Time.now.utc - 60) do
          Fabricate.create(:task, status: 'in progress')
          Fabricate.create(:task, status: 'assigned')
          Fabricate.create(:task, status: 'done')
          Fabricate.create(:task, status: 'closed')
        end
        Timecop.freeze(Time.now.utc)
      end

      after { Timecop.return }

      it 'returns arrays with task counts' do
        tasks = subject[:tasks]
        expect(tasks[:in_progress].last).to eq 1
        expect(tasks[:assigned].last).to eq 1
        expect(tasks[:closed].last).to eq 1
        expect(tasks[:done].last).to eq 1
      end
    end
  end
end

