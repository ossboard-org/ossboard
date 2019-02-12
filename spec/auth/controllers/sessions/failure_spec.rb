require_relative '../../../../apps/auth/controllers/sessions/failure'

RSpec.describe Auth::Controllers::Sessions::Failure, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(action.call(params)).to redirect_to('/') }
end
