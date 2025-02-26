class CreateReminders < ActiveRecord::Migration[7.2]
  def change
    create_table :reminders do |t|
      t.datetime :reminder_date, null: false
      t.boolean :completed, null: false, default: false
      t.references :list_item, null: true, foreign_key: true
      t.timestamps
    end
  end
end
