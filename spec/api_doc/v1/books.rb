module ApiDoc
  module V1
    module Authors
      extend Dox::DSL::Syntax

      # define common data for each test
      document :api do
        resource 'Authors' do
          endpoint '/authors'
          group 'Authors'
        end
      end

      # define data for specific test
      document :index do
        action 'Get bids'
      end
    end
  end
end
