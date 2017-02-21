class Flat < ApplicationRecord
  has_many :listings
  belongs_to :floorplan, optional: true

  def name
    floor + stack
  end

  def value_score
    last_listing = listings.last
    
    floor.to_i + sqft + last_listing.price
  end
end
