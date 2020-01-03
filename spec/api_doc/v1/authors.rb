# frozen_string_literal: true

module ApiDoc
  module V1
    module Authors
      extend Dox::DSL::Syntax

      document :api do
        resource 'Authors' do
          endpoint '/authors'
          group 'Authors'
          desc 'Normal desc'
        end
      end

      document :index do
        action 'Get authors' do
          response_schema_success 'authors'
        end
      end

      document :show do
        action 'Get an author' do
          response_schema_success 'author'
        end
      end

      document :update do
        action 'Update an author' do
          request_schema 'author'
          response_schema_success 'author'
        end
      end

      document :create do
        action 'Create an author' do
          request_schema 'author'
          response_schema_success 'author'
        end
      end

      document :destroy do
        action 'Delete an author' do
          response_schema_success 'author'
        end
      end
    end
  end
end
