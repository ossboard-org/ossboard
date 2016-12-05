require 'spec_helper'
require_relative '../../../../apps/web/controllers/tasks/index'

RSpec.describe Web::Controllers::Tasks::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(action.call(params)).to be_success }
end
