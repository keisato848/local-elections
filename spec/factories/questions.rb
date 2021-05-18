FactoryBot.define do
  factory :question do
    user
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
  end
end
