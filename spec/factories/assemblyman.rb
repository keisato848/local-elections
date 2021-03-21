FactoryBot.define do
  factory :assemblyman do
    name { Faker::Name.name }
    sex {'男性'}
    birth_of_date { Faker::Date.between(from: 100.years.ago, to: Date.today) }
    position { Faker::Lorem.sentence }
    faction { Faker::Lorem.sentence }
    number_of_wins { Faker::Number.number(digits: 2) }
    job { Faker::Job.title }
    img_url { Faker::Internet.url }
    twitter_url { 'gikaitarou'}
    council_id { Faker::Number.number(digits: 2) }
  end
end
