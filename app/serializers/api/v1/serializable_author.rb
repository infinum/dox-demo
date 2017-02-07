module Api
  module V1
    class SerializableAuthor < JSONAPI::Serializable::Resource
      type 'authors'

      attributes :name
      
      has_many :books, class: SerializableBook do
      end
    end
  end
end
