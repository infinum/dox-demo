class Book < ApplicationRecord
  belongs_to :author
  belongs_to :collection

  validates :name, presence: true
end
