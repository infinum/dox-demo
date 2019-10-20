# frozen_string_literal: true

module ApiDoc
  module V1
    module Books
      extend Dox::DSL::Syntax

      document :api do
        resource 'Books' do
          endpoint '/books'
          group 'Books'
          desc 'books.md'
          schema 'api/v1/books'
        end
      end

      document :index do
        action 'Get books'
      end

      document :show do
        action 'Get a book'
      end

      document :update do
        action 'Update a book'
      end

      document :create do
        action 'Create a book'
      end

      document :destroy do
        action 'Delete a book'
      end
    end
  end
end
