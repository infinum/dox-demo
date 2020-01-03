# frozen_string_literal: true

class BookCollection < ApplicationRecord
  has_many :books

  validates :name, presence: true
end
