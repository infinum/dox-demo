# frozen_string_literal: true

module JsonApiStandard
  extend ActiveSupport::Concern

  def deserialized_params
    @deserialized_body ||= ActionController::Parameters.new(
      JSONAPI::Deserializable::Resource.call(JSON.parse(request.body.read))
    )
  end
end
