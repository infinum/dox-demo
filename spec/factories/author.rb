FactoryGirl.define do
  factory :author do
    sequence(:name) { |n| "Author_#{n}" }
  end
end
