class AddLatitudeAndLongitudeToSpots < ActiveRecord::Migration[7.2]
  def change
    add_column :spots, :latitude, :float
    add_column :spots, :longitude, :float
  end
end
