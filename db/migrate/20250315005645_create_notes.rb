class CreateNotes < ActiveRecord::Migration[7.2]
  def change
    create_table :notes, id: :uuid do |t|
      t.references :travel_book, null: false, type: :uuid, foreign_key: { to_table: :travel_books, primary_key: :uuid }
      t.string :title, null: false
      t.text :body
      t.timestamps
    end
  end
end
