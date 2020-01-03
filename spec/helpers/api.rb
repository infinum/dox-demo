# frozen_string_literal: true

module Helpers
  module Api
    extend ActiveSupport::Concern

    included do
      before(:each) do
        accept_json_api!
      end
    end

    def accept_json_api!
      request.headers[:Accept] = 'application/vnd.api+json'
      request.headers.merge! 'Content-Type' => 'application/vnd.api+json'
    end
  end
end
