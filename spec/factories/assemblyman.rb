FactoryBot.define do
  factory :assemblyman do
    name { Faker::Name.name }
    birth_of_date { Faker::Date.between(from: 100.years.ago, to: Date.today) }
    faction { Faker::Lorem.sentence }
    number_of_wins { Faker::Number.number(digits: 2) }
    img_url { Faker::Internet.url }
    job { Faker::Job.title }
    council_id { Faker::Number.number(digits: 2) }
  end
end
