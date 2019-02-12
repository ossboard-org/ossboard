require_relative '../../../../apps/api/controllers/issue/show'

RSpec.describe Api::Controllers::Issue::Show, :vcr, type: :action do
  include Dry::Monads::Result::Mixin

  let(:action) { described_class.new(operation: operation) }
  let(:params) { {} }

  subject { action.call(params) }

  context 'when operation returns success result' do
    let(:operation) { ->(*) { Success(issue: 'issue') } }

    it { expect(action.call(params)).to be_success }
  end

  context 'when operation returns failure result' do
    let(:operation) { ->(*) { Failure(status: 'error') } }

    it { expect(action.call(params)).to have_http_status(404) }
  end

  context 'with real dependency' do
    let(:action) { described_class.new }
    let(:params) { {} }

    subject do
      VCR.use_cassette("github_success_issue") { action.call(params) }
    end

    it { expect(action.call(params)).to_not be_success }

    context 'when params does not contain issue url' do
      let(:params) { { issue_url: nil } }
      it { expect(subject).to match_in_body(/\A{"error":"empty url"}\z/) }
    end

    context 'when issue url is empty' do
      let(:params) { { issue_url: '' } }
      it { expect(subject).to match_in_body(/\A{"error":"empty url"}\z/) }
    end

    context 'with github url' do
      context 'when issue url is valid github' do
        let(:params) { { issue_url: 'https://github.com/ossboard-org/ossboard/issues/69' } }
        it { expect(subject).to match_in_body(/"title":/) }
        it { expect(subject).to match_in_body(/"body":/) }
        it { expect(subject).to match_in_body(/"html_url":/) }
        it { expect(subject).to match_in_body(/"lang":/) }
        it { expect(subject).to match_in_body(/"repository_name":/) }
        it { expect(subject).to match_in_body(/"complexity":/) }
      end

      context 'when issue url is invalid' do
        let(:params) { { issue_url: 'https://api.github.com/repos/ossboard-org/ossboard/issues/69' } }
        it { expect(subject).to match_in_body(/\A{"error":"invalid url"}\z/) }
      end
    end

    context 'with gitlab url' do
      subject do
        VCR.use_cassette("gitlab_success_issue") { action.call(params) }
      end

      context 'when issue url is valid gitlab' do
        let(:params) { { issue_url: 'https://gitlab.com/gitlab-org/gitlab-ce/issues/28059' } }
        it { expect(subject).to match_in_body(/"title":/) }
        it { expect(subject).to match_in_body(/"body":/) }
        it { expect(subject).to match_in_body(/"html_url":/) }
        it { expect(subject).to match_in_body(/"repository_name":/) }
      end
    end
  end
end
