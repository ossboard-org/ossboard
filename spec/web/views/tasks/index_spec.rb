require_relative '../../../../apps/web/views/tasks/index'

RSpec.describe Web::Views::Tasks::Index do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tasks/index.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  let(:repository) { TaskRepository.new }

  describe '#tasks' do
    before do
      3.times { |i| TaskRepository.new.create(title: "title ##{i}") }
    end

    it 'returns all tasks' do
      expect(view.tasks).to eq repository.all
    end
  end
end
