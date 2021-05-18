FactoryBot.define do
  factory :manifest_tag do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
    name { Faker::Lorem.sentence }
  end
end
