class CreateFlats < ActiveRecord::Migration[5.0]
  def change
    create_table :flats do |t|
      t.integer :bed
      t.integer :bath
      t.string :suite
      t.string :floor
      t.integer :sqft
      t.boolean :is_active

      t.timestamps
    end
  end
end
