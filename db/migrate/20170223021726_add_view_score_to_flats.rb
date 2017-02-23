class AddViewScoreToFlats < ActiveRecord::Migration[5.0]
  def change
    add_column :flats, :city_view, :integer
  end
end
