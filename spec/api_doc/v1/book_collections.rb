# frozen_string_literal: true

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
        action 'Get book collections' do
          response_schema_success 'book_collections'
        end
      end

      document :show do
        action 'Get a book collection' do
          response_schema_success 'book_collection'
        end
      end

      document :update do
        action 'Update a book collection' do
          request_schema 'book_collection'
          response_schema_success 'book_collection'
        end
      end

      document :create do
        action 'Create a book collection' do
          request_schema 'book_collection'
          response_schema_success 'book_collection'
        end
      end

      document :destroy do
        action 'Delete a book collection' do
          response_schema_success 'book_collection'
        end
      end
    end
  end
end
