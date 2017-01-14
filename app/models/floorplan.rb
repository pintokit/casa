class Floorplan < ApplicationRecord
  has_many :flats
  serialize :windows, HashSerializer
  store_accessor :windows, :left_window, :middle_window, :right_window
end
