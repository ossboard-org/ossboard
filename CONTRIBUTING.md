OSSBoard is an open source project and we would love you to help us make it better.

## Reporting Issues

A well formatted issue is appreciated, and goes a long way in helping us help you.

* Make sure you have a [GitHub account](https://github.com/signup/free)
* Submit a [Github issue](https://github.com/davydovanton/ossboard/issues/new) by:
  * Clearly describing the issue
    * Provide a descriptive summary
    * Explain the expected behavior
    * Explain the actual behavior
    * Provide steps to reproduce the actual behavior
    * Put application stacktrace as text (in a [Gist](https://gist.github.com) for bonus points)
    * Any relevant stack traces

If you provide code, make sure it is formatted with the triple backticks (\`).

At this point, we'd love to tell you how long it will take for us to respond,
but we just don't know.

## Pull requests

We accept pull requests to OSSBBoard for:

* Fixing bugs
* Adding new features

Not all features proposed will be added but we are open to having a conversation
about a feature you are championing.

Here's a quick guide:

1. Fork the repo.

2. Run the tests. This is to make sure your starting point works. Run `HANAMI_ENV=test bundle exec hanami db prepare` to create the test database. Tests can be run via `bundle exec rspec`

3. Create a new branch and make your changes. This includes tests for features!

4. Push to your fork and submit a pull request. For more information, see
[Github's pull request help section](https://help.github.com/articles/using-pull-requests/).

5. Make sure you do not delete/update the existing cassettes as tests are dependent on them. 

6. Delete log/development.log and capybara-*.html. 

At this point you're waiting on us. Expect a conversation regarding your pull
request; Questions, clarifications, and so on.

## How to install project

1. register a new github OAuth application. You can do it [here](https://github.com/settings/applications/new). Set Authorization callback URL to http://127.0.0.1:2300/auth/github/callback
2. register a new gitlab Personal Access Token. You can do it [here](https://gitlab.com/profile/personal_access_tokens).
3. install http://phantomjs.org/download.html (you can check travisCI file for more information)
4. setup PostgreSQL referring to your OS manual or from [here](https://www.postgresql.org/download/)
5. run these commands:

```
$ bundle install
$ npm install
$ cp .env.development.sample .env.development && cp .env.test.sample .env.test
$ bundle exec hanami db prepare
$ HANAMI_ENV=test bundle exec hanami db prepare
$ bundle exec rspec
$ GITHUB_KEY='your github key' GITHUB_SECRET='your github secret' bundle exec hanami server
```

## Troubleshooting

If you are using peer authentication and get password request,
update `DATABASE_URL` in `.env.{ENVIRONMENT}` not to include host.

Example:
```
# .env.test

DATABASE_URL="postgres:///ossboard_test"
```
