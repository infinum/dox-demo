class Book < ApplicationRecord
  belongs_to :author
  belongs_to :book_collection, optional: true

  validates :name, presence: true
end
