require_relative '../../../../apps/web/views/users/settings'

RSpec.describe Web::Views::Users::Settings, type: :view do
  let(:exposures) { Hash[] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/users/settings.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }
end
