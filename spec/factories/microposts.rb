FactoryBot.define do
  factory :micropost do
    sequence(:title) { |n| "第#{n}回タイトル" }
    sequence(:content) { |n| "第#{n}回説明文" }
    latlng { '(37, 137)' }
    association :user
  end
end
