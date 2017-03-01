module JsonApiHelpers
  def json_api_attrs_for(resource, options = {})
    {}.tap do |body|
      body[:data] = {}
      body[:data][:type] = resource.to_s.pluralize
      body[:data][:id] = options[:id]
      body[:data][:attributes] = attributes_for(resource, options.except(:id))
    end.compact
  end

  def update_params_for(resource, options = {})
    { id: resource.id }.merge(json_api_attrs_for(:author, { id: resource.id }.merge(options)))
  end
end
