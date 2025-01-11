# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Areasテーブルに値を格納
ApplicationRecord.transaction do
areas = [
  { id: 1, name: "Hokkaido" },
  { id: 2, name: "Tohoku" },
  { id: 3, name: "KitaKanto" },
  { id: 4, name: "Syutoken" },
  { id: 5, name: "Koshinetsu" },
  { id: 6, name: "Tokai" },
  { id: 7, name: "Hokuriku" },
  { id: 8, name: "Kinki" },
  { id: 9, name: "SaninSanyou" },
  { id: 10, name: "Shikoku" },
  { id: 11, name: "Kyushu" },
  { id: 12, name: "Okinawa" },
  { id: 13, name: "other" }
]

  areas.each do |area|
    Area.find_or_create_by(id: area[:id]) do |a|
      a.name = area[:name]
    end
  end

  # TravelerTypesテーブルに値を格納
  traveler_types = [
    { id: 1, name: "family" },
    { id: 2, name: "friends" },
    { id: 3, name: "alone" },
    { id: 4, name: "couple" },
    { id: 5, name: "other" }
  ]

  traveler_types.each do | traveler_type |
    TravelerType.find_or_create_by(id: traveler_type[:id]) do |t|
      t.name = traveler_type[:name]
    end
  end
end
