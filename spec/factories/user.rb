FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'testtest1' }
    password_confirmation { password }
    nickname { Faker::Name.name }
  end
end
