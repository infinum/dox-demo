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

        group 'Authors' do
          desc 'Authors group' do
            request_schema 'namespace/authors'
            response_schema_success 'namespace/authors_s'
            response_schema_fail 'namespace/authors_f'
          end
        end
      end

      document :index do
        action 'Get authors' do
          request_schema 'namespace/authors'
          response_schema_success 'namespace/authors_s'
          response_schema_fail 'namespace/authors_f'
        end
      end

      document :show do
        action 'Get an author' do
          request_schema 'namespace/authors'
          response_schema_success 'namespace/authors_s'
          response_schema_fail 'namespace/authors_f'
        end
      end

      document :update do
        action 'Update an author' do
          request_schema 'namespace/authors'
          response_schema_success 'namespace/authors_s'
          response_schema_fail 'namespace/authors_f'
        end
      end

      document :create do
        action 'Create an author' do
          request_schema 'namespace/authors'
          response_schema_success 'namespace/authors_s'
          response_schema_fail 'namespace/authors_f'
        end
      end

      document :destroy do
        action 'Delete an author' do
          request_schema 'namespace/authors'
          response_schema_success 'namespace/authors_s'
          response_schema_fail 'namespace/authors_f'
        end
      end
    end
  end
end
