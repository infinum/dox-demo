module Api
  module V1
    class SerializableBook < JSONAPI::Serializable::Resource
      type 'books'
      attributes :name

      belongs_to :author, class: SerializableAuthor do
      end

      belongs_to :book_collection, class: SerializableBookCollection do
      end
    end
  end
end
