FactoryBot.define do
  factory :council do
    name { Faker::Team.name }
    prefecture_id { 1 }
  end
end
