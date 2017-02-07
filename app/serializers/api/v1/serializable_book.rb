module Api
  module V1
    class SerializableBook < JSONAPI::Serializable::Resource
      type 'books'
      attributes :name
    end
  end
end
