class DeleteCheckListId < ActiveRecord::Migration[7.2]
  def change
    remove_column :list_items, :check_list_id, :bigint
    remove_column :check_lists, :id, :bigint
  end
end
