require_relative '../../../../apps/web/views/users/show'

RSpec.describe Web::Views::Users::Show do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/users/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    expect(view.foo).to eq exposures.fetch(:foo)
  end

  describe '#link_to_task' do
    context 'when task approved' do
      let(:task) { Task.new(id: 1, title: 'test', approved: true) }

      it 'returns link to special task' do
        link = view.link_to_task(task)
        expect(link.to_s).to eq '<a href="/tasks/1">test</a>'
      end
    end

    context 'when task not approved' do
      let(:task) { Task.new(id: 1, title: 'test', approved: false) }

      it 'returns task title' do
        link = view.link_to_task(task)
        expect(link.to_s).to eq "<span>\ntest\n</span>"
      end
    end
  end
end
