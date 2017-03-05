class AddPropertyToFlats < ActiveRecord::Migration[5.0]
  def change
    add_column :flats, :property, :integer
  end
end
