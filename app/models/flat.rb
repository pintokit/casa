class Flat < ApplicationRecord
  has_many :listings
  has_one :floorplan
end
