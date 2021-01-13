FactoryBot.define do
  factory :user do
    name { Faker::Name.initials(number: 6) }
    sequence(:email) { |n| "example#{n}@examle.com" }
    password { 'foobar' }
    password_confirmation { 'foobar' }
    activated { true }
    activated_at { Time.zone.now }

    trait :admin do
      admin { true }
    end
  end
end
