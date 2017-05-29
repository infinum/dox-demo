module JsonApiHelpers
  def jsonapi_body(id, type, attributes, opts = {})
    b = {}.tap do |body|
      body[:type] = type
      body[:id] = id if id.present?
      body[:attributes] = attributes
    end

    {
      data: b.merge(opts)
    }.to_json
  end
end
