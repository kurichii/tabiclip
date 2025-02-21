class ChangeCheckListPrimaryKey < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :list_items, :check_lists

    execute "ALTER TABLE check_lists DROP CONSTRAINT check_lists_pkey;"
    execute "ALTER TABLE check_lists ADD PRIMARY KEY (uuid);"

    add_foreign_key :list_items, :check_lists, column: :check_list_uuid, primary_key: :uuid
  end
end
