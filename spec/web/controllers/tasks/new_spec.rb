require 'spec_helper'
require_relative '../../../../apps/web/controllers/tasks/new'

RSpec.describe Web::Controllers::Tasks::New do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response).to be_success
  end
end
