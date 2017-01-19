class Flat < ApplicationRecord
  has_many :listings
  belongs_to :floorplan

  def name
    floor + stack
  end
end
