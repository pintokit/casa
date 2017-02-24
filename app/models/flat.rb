class Flat < ApplicationRecord
  has_many :listings
  belongs_to :floorplan, optional: true
  validates :bed, :bath, :sqft, numericality: { only_integer: true }

  def name
    floor + stack
  end

  def value_score
    current_price = listings.last.price
    window_avg = 0
    view = 0
    unless floorplan.nil? || floorplan.window_array.blank?
      window_avg = floorplan.window_array.sum/floorplan.window_array.count
    end
    unless city_view.nil?
      view = city_view_before_type_cast
    end

    price_score = normalize(current_price, 2800, 4700, true)
    window_score = normalize(window_avg, 1, 4, false)
    view_score = normalize(view, 0, 4, false)
    floor_score = normalize(floor.to_i, 3, 37, false)
    sqft_score = normalize(sqft, 463, 906, false)
    return (price_score * 3.5) + window_score + view_score + floor_score + sqft_score
  end

  enum city_view: {'Totally Obstructed': 0, 'Mostly Obstructed': 1, 'Partially Obstructed': 2, 'Unobstructed': 4}
end
