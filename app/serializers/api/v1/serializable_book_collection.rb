module Api
  module V1
    class SerializableBookCollection < JSONAPI::Serializable::Resource
      type 'book_collections'

      attributes :name
      has_many :books, class: SerializableBook do
      end
    end
  end
end
