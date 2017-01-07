RSpec.describe AnalyticReporter do
  subject { AnalyticReporter.new.call }

  after do
    UserRepository.new.clear
    TaskRepository.new.clear
  end

  context 'labels information' do
    it { expect(subject[:labels]).to be_a(Array) }
    it { expect(subject[:labels].count).to eq 31 }
    it { expect(subject[:labels]).to all(be_a(String)) }
    it { expect(subject[:labels].last).to eq Date.today.to_s }
    it { expect(subject[:labels].first).to eq (Date.today - 30).to_s }
  end

  context 'users information' do
    it { expect(subject[:users]).to be_a(Array) }
    it { expect(subject[:users].count).to eq 31 }

    context 'when users not created one month' do
      it { expect(subject[:users]).to all(be == 0) }
    end

    context 'when users was created' do
      before do
        3.times do
          Fabricate.create(:user)
        end

        Timecop.freeze(Time.now + (2 * 60 * 60 * 24)) do
          Fabricate.create(:user)
        end
      end

      it { expect(subject[:users].uniq.count).to eq 2 }
      it { expect(subject[:users].last).to eq 3 }
    end
  end

  context 'tasks information' do
    it { expect(subject[:tasks]).to be_a(Hash) }
    it { expect(subject[:tasks].keys).to eq %i[in_progress assigned closed done] }
    it { expect(subject[:tasks][:in_progress].count).to eq 31 }
    it { expect(subject[:tasks][:assigned].count).to eq 31 }
    it { expect(subject[:tasks][:closed].count).to eq 31 }
    it { expect(subject[:tasks][:done].count).to eq 31 }

    context 'when users not created one month' do
      it { expect(subject[:tasks][:in_progress]).to all(be == 0) }
      it { expect(subject[:tasks][:assigned]).to all(be == 0) }
      it { expect(subject[:tasks][:closed]).to all(be == 0) }
      it { expect(subject[:tasks][:done]).to all(be == 0) }
    end
  end
end

