FactoryBot.define do
  factory :period do
    sequence(:name) { |n| "#{n}時代" }
  end
end
