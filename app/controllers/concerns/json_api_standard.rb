module JsonApiStandard
  extend ActiveSupport::Concern

  def deserialized_params(*whitelisted)
    JSONAPI::Deserializable::Resource.call(
      'data' => params['data'].to_hash
    ).except(:type).select { |k, _v| k.in?(whitelisted) }
  end
end
