require_relative '../../../../apps/web/controllers/tasks/new'

RSpec.describe Web::Controllers::Tasks::New, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(action.call(params)).to be_success }

  describe 'expose' do
    context '#task' do
      it 'returns task by id' do
        action.call(params)
        expect(action.task).to eq Task.new
      end
    end

    context '#params' do
      it 'returns action params' do
        action.call(params)
        expect(action.params).to be_a Hanami::Action::BaseParams
      end
    end
  end
end
