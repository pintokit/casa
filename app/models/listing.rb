class Listing < ApplicationRecord
  belongs_to :flat
  default_scope { order(created_at: :asc) }
  validates :price, numericality: { only_integer: true }
end
