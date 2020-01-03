# frozen_string_literal: true

module Api
  module V1
    class SerializableBookCollection < JSONAPI::Serializable::Resource
      type 'book_collections'

      attributes :name
      has_many :books, class: SerializableBook
    end
  end
end
