FactoryBot.define do
  factory :council do
    prefecture
    name { Faker::Team.name }
  end
end
