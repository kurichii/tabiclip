class AddIconImageToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :icon_image, :string
  end
end
