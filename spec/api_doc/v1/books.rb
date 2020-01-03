# frozen_string_literal: true

module ApiDoc
  module V1
    module Books
      extend Dox::DSL::Syntax

      index_params = {
        author_id: { type: :number, required: :required, value: 1, description: 'author id' }
      }

      document :api do
        resource 'Books' do
          endpoint '/books'
          group 'Books'
          desc 'books.md'
        end
      end

      document :index do
        action 'Get books' do
          response_schema_success 'books'
          params index_params
        end
      end

      document :show do
        action 'Get a book' do
          response_schema_success 'book'
        end
      end

      document :update do
        action 'Update a book' do
          request_schema 'book'
          response_schema_success 'book'
        end
      end

      document :create do
        action 'Create a book' do
          request_schema 'book'
          response_schema_success 'book'
        end
      end

      document :destroy do
        action 'Delete a book' do
          response_schema_success 'book'
        end
      end
    end
  end
end
