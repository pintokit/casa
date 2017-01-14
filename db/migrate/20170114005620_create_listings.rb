class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.belongs_to :flat, foreign_key: true
      t.integer :price
      t.datetime :fetch_date

      t.timestamps
    end
  end
end
