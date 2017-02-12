RSpec.describe GithubIssueRequester, :vcr do
  let(:params) { {} }

  context 'when data is valid' do
    let(:params) { { org: 'ossboard-org', repo: 'ossboard', issue: '69' } }

    it 'returns github issue data' do
      VCR.use_cassette("github_success_issue") do
        data = GithubIssueRequester.(params)
        expect(data[:html_url]).to eq 'https://github.com/ossboard-org/ossboard/issues/69'
        expect(data[:title]).to eq 'Footer has not fixed to page bottom'
        expect(data[:body]).to match('Currently, for the big screen')
        expect(data[:lang]).to eq 'ruby'
        expect(data[:repository_name]).to eq 'ossboard'
        expect(data[:complexity]).to eq 'easy'
      end
    end

    context 'and issue does not have labels' do
      let(:params) { { org: 'ossboard-org', repo: 'ossboard', issue: '11' } }

      it 'returns github issue data' do
        VCR.use_cassette("github_success_issue_without_labels") do
          data = GithubIssueRequester.(params)
          expect(data[:html_url]).to eq 'https://github.com/ossboard-org/ossboard/issues/11'
          expect(data[:title]).to eq 'Update design for web app'
          expect(data[:body]).to match('We need to update mobile version')
          expect(data[:lang]).to eq 'ruby'
          expect(data[:repository_name]).to eq 'ossboard'
          expect(data[:complexity]).to eq nil
        end
      end
    end
  end

  context 'when data is invalid' do
    let(:params) { { org: 'ossboard-or', repo: 'ssboard', issue: '69' } }

    it 'returns github issue data' do
      VCR.use_cassette("github_failed_issue") do
        data = GithubIssueRequester.(params)
        expect(data).to eq(error: 'invalid url')
      end
    end
  end
end
