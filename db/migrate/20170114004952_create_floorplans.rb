class CreateFloorplans < ActiveRecord::Migration[5.0]
  def change
    create_table :floorplans do |t|
      t.belongs_to :flat, foreign_key: true
      t.integer :layout_id
      t.jsonb :windows, default: '{}'

      t.timestamps
    end
  end
end
