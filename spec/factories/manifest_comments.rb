FactoryBot.define do
  factory :manifest_comment do
    content { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
  end
end
