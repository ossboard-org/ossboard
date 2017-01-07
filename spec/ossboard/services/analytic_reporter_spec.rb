RSpec.describe AnalyticReporter do
  subject { AnalyticReporter.new.call }

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

    context 'when users created in last month' do
      before do
        10.times do
          random_days_count = rand(30) * 60 * 60 * 24
          Fabricate.create(:user, created_at: Time.now - random_days_count)
        end
      end

      after { UserRepository.new.clear }

      it { expect(subject[:users].uniq.size).to be > 1 }
    end
  end
end

