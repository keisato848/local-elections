FactoryBot.define do
  factory :user do
    email { 'example@example.com' }
    password { 'testtest1' }
    password_confirmation { password }
    nickname { Faker::Name.name }
  end
end
