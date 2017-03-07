module Helpers
  module Api
    extend ActiveSupport::Concern

    included do
      before(:each) do
        accept_json_api!
      end
    end

    def accept_json_api!
      request.headers[:Accept] = 'application/json'
      request.headers.merge! 'Content-Type' => 'application/json'
    end
  end
end
