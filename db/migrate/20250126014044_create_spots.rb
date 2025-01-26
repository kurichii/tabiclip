class CreateSpots < ActiveRecord::Migration[7.2]
  def change
    create_table :spots do |t|
      t.references :schedule, null: true, foreign_key: true
      t.string :name, null: false
      t.string :telephone
      t.string :post_code
      t.string :address
      t.timestamps
    end
  end
end
