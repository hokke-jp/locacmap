FactoryBot.define do
  factory :user do
    name { 'Alice' }
    email { 'Alice@examle.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
    admin { true }
    activated { true }
    activated_at { Time.zone.now }
  end
end
