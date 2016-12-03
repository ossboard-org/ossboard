require_relative '../../../../apps/auth/controllers/sessions/create'

RSpec.describe Auth::Controllers::Sessions::Create do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:onmiauth_hash) do
    {
      "uid"=>"1147484",
      "extra"=> {
        "raw_info"=> {
          "login"=>"davydovanton",
          "id"=>1147484,
          "avatar_url"=>"https://avatars.githubusercontent.com/u/1147484?v=3",
          "gravatar_id"=>"",
          "url"=>"https://api.github.com/users/davydovanton",
          "html_url"=>"https://github.com/davydovanton",
          "followers_url"=>"https://api.github.com/users/davydovanton/followers",
          "following_url"=>
          "https://api.github.com/users/davydovanton/following{/other_user}",
            "gists_url"=>"https://api.github.com/users/davydovanton/gists{/gist_id}",
            "starred_url"=>
          "https://api.github.com/users/davydovanton/starred{/owner}{/repo}",
            "subscriptions_url"=>
          "https://api.github.com/users/davydovanton/subscriptions",
            "organizations_url"=>"https://api.github.com/users/davydovanton/orgs",
            "repos_url"=>"https://api.github.com/users/davydovanton/repos",
            "events_url"=>
          "https://api.github.com/users/davydovanton/events{/privacy}",
            "received_events_url"=>
          "https://api.github.com/users/davydovanton/received_events",
            "type"=>"User",
            "site_admin"=>false,
            "name"=>"Anton Davydov",
            "company"=>nil,
            "blog"=>"http://davydovanton.com",
            "location"=>"Moscow, Russia",
            "email"=>"mail@davydovanton.com",
            "hireable"=>nil,
            "bio"=> "Indie OSS developer",
            "public_repos"=>140,
            "public_gists"=>34,
            "followers"=>140,
            "following"=>35,
            "created_at"=>"2011-10-24T06:11:14Z",
            "updated_at"=>"2016-11-20T10:58:46Z"
        },
        "all_emails"=>[]
      }
    }
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
