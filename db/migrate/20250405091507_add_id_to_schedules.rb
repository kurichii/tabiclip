class AddIdToSchedules < ActiveRecord::Migration[7.2]
  def up
    # 関連する外部キー制約を削除
    remove_foreign_key :spots, column: :schedule_uuid

    # 既存の主キーを削除
    execute "ALTER TABLE schedules DROP CONSTRAINT schedules_pkey;"

    # idカラムを追加
    add_column :schedules, :id, :primary_key

    # 関連付けを作成する（カラム、インデックス、外部キーを作成）
    add_reference :spots, :schedule, null: false, foreign_key: true

    # schedule_uuid カラムを削除
    remove_column :spots, :schedule_uuid
  end

  def down
    # 関連付けを削除する
    remove_reference :spots, :schedule, foreign_key: true, index: false

    # 既存の主キーを削除
    execute "ALTER TABLE schedules DROP CONSTRAINT schedules_pkey;"

    # 主キーをuuidに変更
    execute "ALTER TABLE schedules ADD PRIMARY KEY (uuid);"

    # uuidカラムを追加
    add_column :spots, :schedule_uuid, :uuid

    # 関連する外部キー制約を追加
    add_foreign_key :spots, :schedules, column: :schedule_uuid, primary_key: :uuid

    # idカラムを削除
    remove_column :schedules, :id, :bigint
  end
end
