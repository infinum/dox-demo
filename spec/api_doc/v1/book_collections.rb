module ApiDoc
  module V1
    module BookCollections
      extend Dox::DSL::Syntax

      document :api do
        resource 'Book Collections' do
          endpoint '/book_collections'
          group 'Books'
        end
      end

      document :index do
        action 'Get book collections'
      end

      document :show do
        action 'Get a book collection'
      end

      document :update do
        action 'Update a book collection'
      end

      document :create do
        action 'Create a book collection'
      end

      document :destroy do
        action 'Delete a book collection'
      end
    end
  end
end
