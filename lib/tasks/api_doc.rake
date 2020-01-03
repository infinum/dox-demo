# frozen_string_literal: true

namespace :api do
  namespace :doc do
    desc 'Generate API documentation markdown'
    task :md do
      require 'rspec/core/rake_task'

      RSpec::Core::RakeTask.new(:api_spec) do |t|
        t.pattern = 'spec/controllers/api/v1/'
        t.rspec_opts = '-f Dox::Formatter --order defined --tag dox --out public/api/docs/v1/apispec.json'
      end

      Rake::Task['api_spec'].invoke
    end

    task html: :md do
      `redoc-cli bundle -o public/api/docs/v1/index.html public/api/docs/v1/apispec.json`
    end

    task open: :html do
      `open public/api/docs/v1/index.html`
    end

    # task publish: :md do
    #   `apiary publish --path=public/api/docs/v1/apispec.md --api-name=doxdemo`
    # end
  end
end
