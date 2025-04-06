class AddUuidToNotes < ActiveRecord::Migration[7.2]
  def up
    # 既存の主キーを削除
    execute "ALTER TABLE notes DROP CONSTRAINT notes_pkey;"

    # idカラムをuuidカラムに変更
    rename_column :notes, :id, :uuid

    # 新しいbigintのidカラムを主キーとして追加
    add_column :notes, :id, :bigint, null: false, primary_key: true

    # uuidカラムにユニーク制約を追加
    add_index :notes, :uuid, unique: true
  end

  def down
    # 既存の主キーを削除
    execute "ALTER TABLE notes DROP CONSTRAINT notes_pkey;"

    # uuidカラムをidカラムに変更
    rename_column :notes, :uuid, :id

    # uuidカラムにユニーク制約を追加
    add_index :notes, :id, unique: true

    # 新しいuuidのidカラムを主キーとして追加
    execute "ALTER TABLE notes ADD PRIMARY KEY (uuid);"

    # uuidカラムを削除
    remove_index :notes, :uuid
    remove_column :notes, :uuid, :uuid
  end
end
