class Flat < ApplicationRecord
  has_many :listings
  belongs_to :floorplan, optional: true

  def name
    floor + stack
  end

  def window_score
    window_count = 0
    unless floorplan.nil? || floorplan.windows.nil?
      floorplan.windows.each_value do |window|
        window_count += window.to_i
      end
    end
    score = normalize(window_count, 2, 5, false)
    return score
  end

  def floor_score
    score = normalize(floor.to_i, 3, 37, false)
    return score
  end

  def sqft_score
    score = normalize(sqft, 463, 906, false)
    return score
  end

  def price_score
    current_price = listings.last.price
    score = normalize(current_price, 2800, 4700, true)
    return score
  end

  def value_score
    return window_score + floor_score + sqft_score + price_score
  end
end
