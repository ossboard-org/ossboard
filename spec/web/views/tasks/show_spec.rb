require 'spec_helper'
require_relative '../../../../apps/web/views/tasks/show'

RSpec.describe Web::Views::Tasks::Show do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tasks/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    expect(view.foo).to eq exposures.fetch(:foo)
  end

  describe 'nav bar actions' do
    it { expect(view.tasks_active?).to be true }
  end
end
