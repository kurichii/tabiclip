FactoryBot.define do
  factory :user do
    name { "name" }
    sequence(:email) { |n| "#{n}@example.com" }
    password { "password" }
  end
end
