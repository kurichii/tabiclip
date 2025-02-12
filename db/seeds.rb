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
  { id: 1, name: "北海道" },
  { id: 2, name: "東北" },
  { id: 3, name: "北関東" },
  { id: 4, name: "首都圏" },
  { id: 5, name: "甲信越" },
  { id: 6, name: "東海" },
  { id: 7, name: "北陸" },
  { id: 8, name: "近畿" },
  { id: 9, name: "山陰・山陽" },
  { id: 10, name: "四国" },
  { id: 11, name: "九州" },
  { id: 12, name: "沖縄" },
  { id: 13, name: "その他" }
]

  areas.each do |area|
    Area.find_or_create_by(id: area[:id]) do |a|
      a.name = area[:name]
    end
  end

  # TravelerTypesテーブルに値を格納
  traveler_types = [
    { id: 1, name: "家族" },
    { id: 2, name: "友人" },
    { id: 3, name: "一人旅" },
    { id: 4, name: "夫婦・カップル" },
    { id: 5, name: "その他" }
  ]

  traveler_types.each do | traveler_type |
    TravelerType.find_or_create_by(id: traveler_type[:id]) do |t|
      t.name = traveler_type[:name]
    end
  end
end
