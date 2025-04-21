FactoryBot.define do
  factory :travel_book do
    title { "title" }
    is_public { false }
    uuid { SecureRandom.uuid }

    # オプション
    description { nil }
    start_date { nil }
    end_date { nil }
    travel_book_image { nil }
    invitation_token { nil }
    area { nil }
    traveler_type { nil }

    # アソシエーション
    association :creator, factory: :user
  end
end
