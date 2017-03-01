class Book < ApplicationRecord
  belongs_to :author
  belongs_to :book_collection, optional: true

  validates :name, presence: true

  scope :authored_by, ->(author_id) { where(author_id: author_id) }
end
