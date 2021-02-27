FactoryBot.define do
  factory :prefecture do
    name { Faker::Nation.capital_city }
  end
end
