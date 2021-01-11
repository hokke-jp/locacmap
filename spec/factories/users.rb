FactoryBot.define do
  factory :user do
    name                  {"Alice"}
    password              {"foobar"}
    password_confirmation {"foobar"}
    sequence(:email) {Faker::Internet.email}
  end
end