class Flat < ApplicationRecord
  has_many :listings
  belongs_to :floorplan, optional: true

  def name
    floor + stack
  end

  def value_score
    current_price = listings.last.price
    window_avg = 0
    window_sum = 0
    unless floorplan.nil? || floorplan.windows.nil?
      floorplan.windows.each_value do |window|
        window_sum += window.to_i
      end
      window_avg = window_sum/floorplan.windows.count
    end

    price_score = normalize(current_price, 2800, 4700, true)
    window_score = normalize(window_avg, 1, 4, false)
    floor_score = normalize(floor.to_i, 3, 37, false)
    sqft_score = normalize(sqft, 463, 906, false)
    return (price_score * 3.5) + window_score + sqft_score + floor_score
  end
end
