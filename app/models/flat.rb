class Flat < ApplicationRecord
  has_many :listings
  belongs_to :floorplan
end
