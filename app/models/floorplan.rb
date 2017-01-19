class Floorplan < ApplicationRecord
  has_many :flats
  serialize :windows, HashSerializer
  store_accessor :windows, :left_window, :middle_window, :right_window

  def layout_path
    "https://www.rentnema.com/img/floorplans/plan/#{layout_id}.jpg"
  end
end
