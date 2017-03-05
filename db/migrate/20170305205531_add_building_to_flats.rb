class AddBuildingToFlats < ActiveRecord::Migration[5.0]
  def change
    add_column :flats, :building, :string
  end
end
