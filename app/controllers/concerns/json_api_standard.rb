module JsonApiStandard
  extend ActiveSupport::Concern

  def deserialized_params
    ActionController::Parameters.new(
      JSONAPI::Deserializable::Resource.call(JSON.parse(request.body.read))
    )
  end
end
