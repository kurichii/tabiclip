class AddIdToCheckLists < ActiveRecord::Migration[7.2]
  def up
    # 関連する外部キー制約を削除
    remove_foreign_key :list_items, column: :check_list_uuid

    # 既存の主キーを削除
    execute "ALTER TABLE check_lists DROP CONSTRAINT check_lists_pkey;"

    # idカラムを追加
    add_column :check_lists, :id, :primary_key

    # 関連付けを作成する（カラム、インデックス、外部キーを作成）
    add_reference :list_items, :check_list, null: false, foreign_key: true

    # check_list_uuid カラムを削除
    remove_column :list_items, :check_list_uuid
  end

  def down
    # 関連付けを削除する
    remove_reference :list_items, :check_list, foreign_key: true, index: false

    # 既存の主キーを削除
    execute "ALTER TABLE check_lists DROP CONSTRAINT check_lists_pkey;"

    # 主キーをuuidに変更
    execute "ALTER TABLE check_lists ADD PRIMARY KEY (uuid);"

    # uuidカラムを追加
    add_column :list_items, :check_list_uuid, :uuid

    # 関連する外部キー制約を追加
    add_foreign_key :list_items, :check_lists, column: :check_list_uuid, primary_key: :uuid

    # idカラムを削除
    remove_column :check_lists, :id, :bigint
  end
end
