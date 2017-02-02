require_relative '../../../../apps/web/views/tasks/new'

RSpec.describe Web::Views::Tasks::New do
  let(:exposures) { Hash[params: { current_user: User.new }] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tasks/new.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  describe '#title' do
    it { expect(view.title).to eq 'OSSBoard: new task' }
  end

  describe '#form' do
    it { expect(view.form).to have_method(:post) }
    it { expect(view.form).to have_action('/tasks') }
  end

  describe 'nav bar actions' do
    it { expect(view.tasks_active?).to be true }
  end

  describe '#validation_errors' do
    let(:exposures) do
      Hash[params: double(error_messages: ['Md Body must be filled', 'Title must be filled'])]
    end

    subject { view.validation_errors }

    it { expect(subject).to include('Body must be filled') }
    it { expect(subject).to include('Title must be filled') }
  end
end
