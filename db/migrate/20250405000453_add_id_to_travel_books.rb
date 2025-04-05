class AddIdToTravelBooks < ActiveRecord::Migration[7.2]
  def up
    # 関連する外部キー制約を削除
    remove_foreign_key :bookmarks, column: :travel_book_uuid
    remove_foreign_key :check_lists, column: :travel_book_uuid
    remove_foreign_key :notes, column: :travel_book_uuid
    remove_foreign_key :schedules, column: :travel_book_uuid
    remove_foreign_key :user_travel_books, column: :travel_book_uuid

    # 既存の主キーを削除
    execute "ALTER TABLE travel_books DROP CONSTRAINT travel_books_pkey;"

    # idカラムを追加
    add_column :travel_books, :id, :primary_key

    # 関連付けを作成する（カラム、インデックス、外部キーを作成）
    add_reference :bookmarks, :travel_book, null: false, foreign_key: true
    add_reference :check_lists, :travel_book, null: false, foreign_key: true
    add_reference :notes, :travel_book, null: false, foreign_key: true
    add_reference :schedules, :travel_book, null: false, foreign_key: true
    add_reference :user_travel_books, :travel_book, null: false, foreign_key: true

    # travel_book_uuid カラムを削除
    remove_column :bookmarks, :travel_book_uuid
    remove_column :check_lists, :travel_book_uuid
    remove_column :notes, :travel_book_uuid
    remove_column :schedules, :travel_book_uuid
    remove_column :user_travel_books, :travel_book_uuid
  end

  def down
    # 関連付けを削除する
    remove_reference :bookmarks, :travel_book, foreign_key: true, index: false
    remove_reference :check_lists, :travel_book, foreign_key: true, index: false
    remove_reference :notes, :travel_book, foreign_key: true, index: false
    remove_reference :schedules, :travel_book, foreign_key: true, index: false
    remove_reference :user_travel_books, :travel_book, foreign_key: true, index: false

    # 既存の主キーを削除
    execute "ALTER TABLE travel_books DROP CONSTRAINT travel_books_pkey;"

    # 主キーをuuidに変更
    execute "ALTER TABLE travel_books ADD PRIMARY KEY (uuid);"

    # uuidカラムを追加
    add_column :bookmarks, :travel_book_uuid, :uuid
    add_column :check_lists, :travel_book_uuid, :uuid
    add_column :notes, :travel_book_uuid, :uuid
    add_column :schedules, :travel_book_uuid, :uuid
    add_column :user_travel_books, :travel_book_uuid, :uuid

    # 関連する外部キー制約を追加
    add_foreign_key :bookmarks, :travel_books, column: :travel_book_uuid, primary_key: :uuid
    add_foreign_key :check_lists, :travel_books, column: :travel_book_uuid, primary_key: :uuid
    add_foreign_key :notes, :travel_books, column: :travel_book_uuid, primary_key: :uuid
    add_foreign_key :schedules, :travel_books, column: :travel_book_uuid, primary_key: :uuid
    add_foreign_key :user_travel_books, :travel_books, column: :travel_book_uuid, primary_key: :uuid

    # idカラムを削除
    remove_column :travel_books, :id, :bigint
  end
end
