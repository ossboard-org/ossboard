# frozen_string_literal: true

RSpec.describe Tasks::Operations::IssueInformation do
  let(:operation) do
    described_class.new(
      github_issue_requester: github_issue_requester,
      gitlab_issue_requester: gitlab_issue_requester
    )
  end

  let(:github_issue_requester) { double('Tasks::Services::GithubIssueRequester', call: { status: :ok }) }
  let(:gitlab_issue_requester) { double('Tasks::Services::GitlabIssueRequester', call: { status: :ok }) }
  let(:params) { { issue_url: 'http://github.com/ossboard-org/ossboard/issues/211' } }

  context 'when data has valid schema' do
    subject { operation.call(true, params) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(status: :ok) }
  end

  context 'when data has invalid schema' do
    subject { operation.call(false, params) }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(error: 'empty url') }
  end

  context 'when data has invalid URL' do
    subject { operation.call(true, params) }

    let(:params) { { issue_url: 'test.com' } }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(error: 'invalid url') }
  end
end
