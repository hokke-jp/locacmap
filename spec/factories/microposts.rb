FactoryBot.define do
  factory :micropost do
    content { 'Lorem ipsum' }
    user_id { User.first.id }
  end
end
