source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'dox', require: false, github: 'infinum/dox'
gem 'jsonapi-rails'
gem 'json_api_responders', github: 'infinum/json_api_responders', branch: 'feature/jsonapi-rails-support'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.1'
gem 'sqlite3'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
