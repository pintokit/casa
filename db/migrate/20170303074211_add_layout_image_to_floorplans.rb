class AddLayoutImageToFloorplans < ActiveRecord::Migration[5.0]
  def change
    add_column :floorplans, :layout_image, :integer
  end
end
