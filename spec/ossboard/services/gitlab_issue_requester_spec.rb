RSpec.describe Services::GitlabIssueRequester, :vcr do
  let(:params) { { org: 'gitlab-org', repo: 'gitlab-ce', issue: '28059' } }

  context 'when data is valid' do
    it 'returns gitlab issue data' do
      VCR.use_cassette('gitlab_success_issue') do
        data = subject.(params)
        expect(data[:html_url]).to eq 'https://gitlab.com/gitlab-org/gitlab-ce/issues/28059'
        expect(data[:title]).to eq 'No pagination on abuse_reports'
        expect(data[:body]).to match('paginate @abuse_reports')
        expect(data[:repository_name]).to eq 'GitLab Community Edition'
        expect(data[:complexity]).to eq 'medium'
      end
    end

    context 'and issue does not have labels' do
      it 'returns gitlab issue data' do
        VCR.use_cassette('gitlab_success_issue_without_labels') do
          data = subject.(params)

          expect(data[:html_url]).to eq 'https://gitlab.com/gitlab-org/gitlab-ce/issues/28059'
          expect(data[:title]).to eq 'No pagination on abuse_reports'
          expect(data[:body]).to match('paginate @abuse_reports')
          expect(data[:repository_name]).to eq 'GitLab Community Edition'
          expect(data[:complexity]).to eq nil
        end
      end
    end
  end

  context 'when data is invalid' do
    let(:params) { { org: 'gitlab-org', repo: 'gitlab-ce-', issue: '28059' } }

    it 'returns invalid url message' do
      VCR.use_cassette('gitlab_failed_issue') do
        data = subject.(params)
        expect(data).to eq(error: 'invalid url')
      end
    end
  end

 context 'when data is not authorized' do
    it 'returns unathorized messages' do
      VCR.use_cassette('gitlab_unathorized_issue') do
        data = subject.(params)
        expect(data).to eq(error: 'Unauthorized')
      end
    end
  end
end
