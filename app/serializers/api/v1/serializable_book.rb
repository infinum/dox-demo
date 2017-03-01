module Api
  module V1
    class SerializableBook < JSONAPI::Serializable::Resource
      type 'books'
      attributes :name

      belongs_to :author, class: SerializableAuthor

      belongs_to :book_collection, class: SerializableBookCollection
    end
  end
end
