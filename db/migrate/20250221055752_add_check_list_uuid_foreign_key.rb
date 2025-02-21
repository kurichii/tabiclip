class AddCheckListUuidForeignKey < ActiveRecord::Migration[7.2]
  def change
    add_column :list_items, :check_list_uuid, :uuid

    ListItem.reset_column_information
    ListItem.find_each { |li| li.update_column(:check_list_uuid, CheckList.find(li.check_list_id).uuid) }

    change_column_null :list_items, :check_list_uuid, false
  end
end
