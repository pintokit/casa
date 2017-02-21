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
    score = normalize(window_count, 2, 4, false)
    return score
  end
end
