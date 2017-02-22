class Flat < ApplicationRecord
  has_many :listings
  belongs_to :floorplan, optional: true

  def name
    floor + stack
  end

  def value_score
    current_price = listings.last.price
    window_count = 0
    unless floorplan.nil? || floorplan.windows.nil?
      floorplan.windows.each_value do |window|
        window_count += window.to_i
      end
    end
    
    price_score = normalize(current_price, 2800, 4700, true)
    window_score = normalize(window_count, 2, 5, false)
    floor_score = normalize(floor.to_i, 3, 37, false)
    sqft_score = normalize(sqft, 463, 906, false)
    return price_score + window_score + floor_score + sqft_score
  end
end
