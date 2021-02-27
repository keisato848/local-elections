FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
  end
end
