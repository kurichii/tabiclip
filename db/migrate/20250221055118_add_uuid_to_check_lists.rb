class AddUuidToCheckLists < ActiveRecord::Migration[7.2]
  def change
    add_column :check_lists, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :check_lists, :uuid, unique: true

    CheckList.reset_column_information
    CheckList.find_each { |check_list| check_list.update_column(:uuid, SecureRandom.uuid) }
  end
end
