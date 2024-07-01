FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Internet.unique.username }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6) }
  end
end
