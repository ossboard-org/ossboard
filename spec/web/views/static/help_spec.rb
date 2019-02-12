require_relative '../../../../apps/web/views/static/help'

RSpec.describe Web::Views::Static::Help, type: :view do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/static/help.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    expect(view.foo).to eq exposures.fetch(:foo)
  end

  describe '#title' do
    it { expect(view.title).to eq 'OSSBoard' }
  end
end
