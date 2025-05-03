class AddDisplayOrderToScheduleIcons < ActiveRecord::Migration[7.2]
  def change
    add_column :schedule_icons, :display_order, :integer
  end
end
