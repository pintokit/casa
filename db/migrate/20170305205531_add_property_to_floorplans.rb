class AddPropertyToFloorplans < ActiveRecord::Migration[5.0]
  def change
    add_column :floorplans, :hirise, :integer
  end
end
