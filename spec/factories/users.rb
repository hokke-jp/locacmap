FactoryBot.define do
  factory :user do
    sequence(:name)         {Faker::Name.initials(number: 6)}
    sequence(:email)        {Faker::Internet.free_email}
    password                { 'password' }
    password_confirmation   { 'password' }
    activated { true }
    activated_at { Time.zone.now }
  end
end
