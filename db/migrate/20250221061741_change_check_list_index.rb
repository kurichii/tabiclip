class ChangeCheckListIndex < ActiveRecord::Migration[7.2]
  def change
    remove_index :list_items, name: "index_list_items_on_check_list_id"

    add_index :list_items, :check_list_uuid
  end
end
