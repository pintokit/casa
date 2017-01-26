class FlatSerializer < ActiveModel::Serializer
  has_many :listings
  belongs_to :floorplan, optional: true
  
  attributes :bed, :bath, :stack, :floor, :sqft, :is_active
end
