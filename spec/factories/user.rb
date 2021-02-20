FactoryBot.define do
  factory :user do
    email { 'example@example.com' }
    password {'testtest1'}
    password_confirmation { password }
    nickname { '議会太郎' }
  end
end