RSpec.describe AnalyticReporter do
  subject { AnalyticReporter.new.call }

  it { expect(subject[:labels]).to be_a(Array) }
  it { expect(subject[:labels].count).to eq 31 }
  it { expect(subject[:labels].last).to eq Date.today.to_s }
  it { expect(subject[:labels].first).to eq (Date.today - 30).to_s }
end

