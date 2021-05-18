FactoryBot.define do
  factory :question_comment do
    content { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
  end
end
