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

  schedule_icons = [
    { id: 1, name: "none", display_order: 1 },
    { id: 2, name: "fa-person-walking", display_order: 2 },
    { id: 3, name: "fa-bicycle", display_order: 3 },
    { id: 4, name: "fa-car", display_order: 4 },
    { id: 5, name: "fa-train-subway", display_order: 6 },
    { id: 6, name: "fa-plane-up", display_order: 7 },
    { id: 7, name: "fa-ship", display_order: 8 },
    { id: 8, name: "fa-hotel", display_order: 9 },
    { id: 9, name: "fa-utensils", display_order: 10 },
    { id: 10, name: "fa-mug-saucer", display_order: 11 },
    { id: 11, name: "fa-cart-shopping", display_order: 12 },
    { id: 12, name: "fa-star", display_order: 13 },
    { id: 13, name: "fa-torii-gate", display_order: 14 },
    { id: 14, name: "fa-guitar", display_order: 15 },
    { id: 15, name: "fa-heart", display_order: 16 },
    { id: 16, name: "fa-baby-carriage", display_order: 17 },
    { id: 17, name: "fa-bus-simple", display_order: 5 },
    { id: 18, name: "fa-paw", display_order: 18 }
  ]

  schedule_icons.each do |schedule_icon|
    icon = ScheduleIcon.find_or_initialize_by(id: schedule_icon[:id])
    icon.name ||= schedule_icon[:name]
    icon.display_order = schedule_icon[:display_order]
    icon.save!
  end
end
