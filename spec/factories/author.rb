# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    sequence(:name) { |n| "Author_#{n}" }
  end
end
