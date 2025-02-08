class ChangeNameColumnToNullOnSpots < ActiveRecord::Migration[7.2]
  def change
    change_column_null :spots, :name, true
  end
end
