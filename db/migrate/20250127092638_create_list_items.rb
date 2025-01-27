class CreateListItems < ActiveRecord::Migration[7.2]
  def change
    create_table :list_items do |t|
      t.references :check_list, null: false, foreign_key: true
      t.string :title, null: false
      t.boolean :completed, default: false, null: false
      t.timestamps
    end
  end
end
