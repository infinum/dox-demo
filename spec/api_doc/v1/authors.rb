# frozen_string_literal: true

module ApiDoc
  module V1
    module Authors
      extend Dox::DSL::Syntax

      document :api do
        resource 'Authors' do
          endpoint '/authors'
          group 'Authors'
          schema 'authors'
        end

        group 'Authors' do
          desc 'Authors group'
        end
      end

      document :index do
        action 'Get authors'
      end

      document :show do
        action 'Get an author'
      end

      document :update do
        action 'Update an author'
      end

      document :create do
        action 'Create an author'
      end

      document :destroy do
        action 'Delete an author'
      end
    end
  end
end
