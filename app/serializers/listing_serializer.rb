class ListingSerializer < ActiveModel::Serializer
  belongs_to :flat
  
  attributes :price, :created_at
end
