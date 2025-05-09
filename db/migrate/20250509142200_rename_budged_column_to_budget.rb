class RenameBudgedColumnToBudget < ActiveRecord::Migration[7.2]
  def change
    rename_column :schedules, :budged, :budget
  end
end
