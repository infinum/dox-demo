# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'json_api_responders'
gem 'jsonapi-rails'
gem 'puma', '~> 3.0'
gem 'rails', '5.0.2'
gem 'sqlite3'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'dox', require: false, path: '/Users/stef/dev/gems/dox'
  gem 'factory_bot_rails'
  gem 'json_matchers', '0.9.0'
  gem 'rspec-rails'
  # gem 'shoulda-matchers'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
