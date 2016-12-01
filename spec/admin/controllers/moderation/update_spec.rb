require 'spec_helper'
require_relative '../../../../apps/admin/controllers/moderation/update'

RSpec.describe Admin::Controllers::Moderation::Update do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  let(:repo) { TaskRepository.new }
  let(:task) { repo.create(title: 'old', approved: false) }

  after { repo.clear }

  let(:params) { { id: task.id } }

  it { expect { action.call(params) }.to change { repo.find(task.id).approved } }
  it { expect(action.call(params)).to redirect_to('/admin/moderation')  }
end
