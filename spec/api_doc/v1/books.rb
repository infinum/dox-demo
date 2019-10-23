# frozen_string_literal: true

module ApiDoc
  module V1
    module Books
      extend Dox::DSL::Syntax

      show_params = { id: { type: :number, required: :required, value: 1, description: 'bid id' } }

      document :api do
        resource 'Books' do
          endpoint '/books'
          group 'Books'
          desc 'books.md'
        end
      end

      document :index do
        action 'Get books' do
          request_schema 'books'
          response_schema_success 'books_s'
          response_schema_fail 'books_f'
          params show_params
        end
      end

      document :show do
        action 'Get a book' do
          request_schema 'books'
          response_schema_success 'books_s'
          response_schema_fail 'books_f'
        end
      end

      document :update do
        action 'Update a book' do
          request_schema 'books'
          response_schema_success 'books_s'
          response_schema_fail 'books_f'
        end
      end

      document :create do
        action 'Create a book' do
          request_schema 'books'
          response_schema_success 'books_s'
          response_schema_fail 'books_f'
        end
      end

      document :destroy do
        action 'Delete a book' do
          request_schema 'books'
          response_schema_success 'books_s'
          response_schema_fail 'books_f'
        end
      end
    end
  end
end
