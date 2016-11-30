source 'https://rubygems.org'

ruby '2.3.0'

gem 'bundler'
gem 'rake'
gem 'hanami',       '~> 0.9'
gem 'hanami-model', '~> 0.7'

gem 'pg'
gem 'travis'

gem 'slim'
gem 'hanami-webpack', github: 'samuelsimoes/hanami-webpack'
gem 'sass'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'

  # gem 'hanami-scaffold', github: 'davydovanton/hanami-scaffold'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'rspec'
  gem 'rspec-hanami'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
