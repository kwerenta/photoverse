FactoryBot.define do
  factory :post do
    caption { Faker::Lorem.sentence }
    user
  end
end
