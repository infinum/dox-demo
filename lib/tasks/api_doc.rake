namespace :api do
  namespace :doc do
    desc 'Generate API documentation markdown'
    task :md do
      require 'rspec/core/rake_task'

      RSpec::Core::RakeTask.new(:api_spec) do |t|
        t.rspec_opts = "spec/controllers/api/v1/* \
          -f Dox::Formatter \
          --order defined \
          --tag apidoc \
          --out public/api/docs/v1/apispec.md"
      end

      Rake::Task['api_spec'].invoke
    end

    task html: :md do
      `aglio -i public/api/docs/v1/apispec.md -o public/api/docs/v1/index.html`
    end

    task open: :html do
      `open public/api/docs/v1/index.html`
    end

    task publish: :md do
      `apiary publish --path=public/api/docs/v1/apispec.md --api-name=dox-demo`
    end
  end
end
