FactoryBot.define do
  factory :note do
    title { "title" }
    body { "body" }

    # アソシエーション
    association :travel_book
  end
end
