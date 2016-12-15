require 'spec_helper'
require_relative '../../../../apps/web/views/tasks/show'

RSpec.describe Web::Views::Tasks::Show do
  let(:exposures) { { author: user, task: task } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tasks/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:user) { User.new(id: 1, name: 'test', email: 'test@ossboard.com') }
  let(:task) { Task.new(id: 1, title: 'task title') }

  describe 'nav bar actions' do
    it { expect(view.tasks_active?).to be true }
  end

  describe '#link_to_author' do
    it 'returns link to special user' do
      link = view.link_to_author
      expect(link.to_s).to eq '<a href="/users/1">test</a>'
    end
  end

  describe '#contact_with_mentor_link' do
    it 'returns link to special user' do
      link = view.contact_with_mentor_link
      expect(link.to_s).to eq '<a class="btn btn-contact task__contact" href="mailto:test@ossboard.com?subject=OSSBoard: task title">Contact with mentor</a>'
    end
  end
end
