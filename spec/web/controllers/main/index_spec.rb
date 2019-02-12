require_relative '../../../../apps/web/controllers/main/index'

RSpec.describe Web::Controllers::Main::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(action.call(params)).to be_success }

  describe 'with last modified cache' do
    let(:task) { Fabricate.create(:task, approved: true) }
    let(:params) { { 'HTTP_IF_MODIFIED_SINCE' => task.created_at.httpdate } }

    it { expect(action.call(params)).to have_http_status 304 }
  end

  describe '#tasks' do
    before do
      10.times { |i| Fabricate.create(:task, title: "title ##{i}", approved: true) }
      action.call(params)
    end

    it { expect(action.tasks.count).to eq 3 }
    it { expect(action.tasks.last.title).to eq 'title #7' }
    it { expect(action.tasks.first.title).to  eq 'title #9' }
  end
end
