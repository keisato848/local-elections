FactoryBot.define do
  factory :manifest do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
  end
end
