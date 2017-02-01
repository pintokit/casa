class FlatSerializer < ActiveModel::Serializer
  belongs_to :floorplan, optional: true

  attributes :bed, :bath, :stack, :floor, :sqft, :is_active, :price_updated_at, :listings

  def listings
    object.listings.all
  end

  def price_updated_at
    object.listings.last.created_at
  end
end
