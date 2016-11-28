require_relative '../../../../apps/web/views/main/index'

RSpec.describe Web::Views::Main::Index do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/main/index.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  let(:repo) { TaskRepository.new }

  describe '#tasks' do
    before do
      10.times { |i| repo.create(title: "title ##{i}", approved: true) }
    end

    after { TaskRepository.new.clear }

    it { expect(view.tasks.count).to eq 3 }
    it { expect(view.tasks.first.title).to eq 'title #0' }
    it { expect(view.tasks.last.title).to  eq 'title #2' }
  end

  describe '#link_to_tasks' do
    it 'returns link to all tasks' do
      expect(view.link_to_tasks.to_s).to eq '<a class="pure-button" href="/tasks">View All Tasks</a>'
    end
  end
end
