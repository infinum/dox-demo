source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'jsonapi-rails'
gem 'json_api_responders', github: 'infinum/json_api_responders', branch: 'feature/jsonapi-rails-support'
gem 'puma', '~> 3.0'
gem 'rails', '5.0.2'
gem 'sqlite3'

group :development, :test do
  gem 'apiaryio', '0.7.0', git: 'https://github.com/infinum/apiary-client.git'
  gem 'byebug', platform: :mri
  gem 'pry-rails'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'dox', require: false
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
