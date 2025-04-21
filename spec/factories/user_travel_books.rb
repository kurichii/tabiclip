FactoryBot.define do
  factory :user_travel_book do
    association :user
    association :travel_book
  end
end