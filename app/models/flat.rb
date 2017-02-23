class Flat < ApplicationRecord
  has_many :listings
  belongs_to :floorplan, optional: true

  def name
    floor + stack
  end

  def value_score
    current_price = listings.last.price
    window_avg = 0
    unless floorplan.nil? || floorplan.window_array.blank?
      window_avg = floorplan.window_array.sum/floorplan.window_array.count
    end

    price_score = normalize(current_price, 2800, 4700, true)
    window_score = normalize(window_avg, 1, 4, false)
    floor_score = normalize(floor.to_i, 3, 37, false)
    sqft_score = normalize(sqft, 463, 906, false)
    return (price_score * 3.5) + window_score + floor_score + sqft_score
  end
end
