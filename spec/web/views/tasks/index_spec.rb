require 'spec_helper'
require_relative '../../../../apps/web/views/tasks/index'

RSpec.describe Web::Views::Tasks::Index do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tasks/index.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  let(:repo) { TaskRepository.new }

  describe '#tasks' do
    before do
      3.times { |i| repo.create(title: "title ##{i}", approved: true) }
    end

    after { TaskRepository.new.clear }

    it 'returns all tasks' do
      expect(view.tasks).to eq repo.all
    end
  end

  describe '#link_to_task' do
    let(:task) { Task.new(id: 1, title: 'test') }

    it 'returns link to special task' do
      link = view.link_to_task(task)
      expect(link.to_s).to eq '<a href="/tasks/1">test</a>'
    end
  end

  describe 'nav bar actions' do
    it { expect(view.tasks_active?).to be true }
  end
end
