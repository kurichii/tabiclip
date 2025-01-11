# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
ApplicationRecord.transaction do
areas = [
  { id: 1, name: "Hokkaido" },
  { id: 2, name: "Tohoku" },
  { id: 3, name: "KitaKanto" },
  { id: 3, name: "Syutoken" },
  { id: 4, name: "Koshinetsu" },
  { id: 4, name: "Tokai" },
  { id: 5, name: "Hokuriku" },
  { id: 5, name: "Kinki" },
  { id: 6, name: "SaninSanyou" },
  { id: 7, name: "Shikoku" },
  { id: 8, name: "Kyushu" },
  { id: 9, name: "Okinawa" }
]

  areas.each do |area|
    Area.find_or_create_by(id: area[:id]) do |a|
      a.name = area[:name]
    end
  end
end